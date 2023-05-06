// ignore_for_file: body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/screen/Signin_Signup_Forgot_Screen/admin.dart';
import 'package:travel_app/screen/Signin_Signup_Forgot_Screen/forgot_screen.dart';
import 'package:travel_app/screen/Signin_Signup_Forgot_Screen/signup_screen.dart';
import 'package:travel_app/utils/color_utils.dart';
import 'package:travel_app/utils/loadingIndicator.dart';

import '../../model/user_model.dart';
import '../../pages/home_page.dart';
import 'googleSignin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();
  String? role;
  String? token;

  Future<void> getFirebaseMessagingToken() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((t) {
      if (t != null) {
        setState(() {
          token = t;
          print('Push Token: $t');
        });
      }
    });
  }

  Future getuser(String uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        role = loggedInUser.role;
      });
    });
  }

  //login function
  Future<void> sigIn(
    String email,
    String password,
  ) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) async => {
                // Fluttertoast.showToast(msg: "Login Successful"),
                // if (FirebaseAuth.instance.currentUser!.emailVerified)
                //   {
                    await getuser(FirebaseAuth.instance.currentUser!.uid),
                    setState(() {
                      role = loggedInUser.role;
                    }),
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => role == "Admin"
                            ? Admin(email: email)
                            : MyHomePage()))
                  // }
                // else
                //   {
                //     Navigator.pop(context),
                //     Fluttertoast.showToast(msg: "Email Not Verified")
                //   }
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: true,
      controller: emailController,
      cursorColor: Colors.black45,
      style: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        //new
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail_outline,
            color: Colors.lightBlue,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
          hintStyle: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                  width: 2, style: BorderStyle.solid, color: Colors.blue)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(width: 0, style: BorderStyle.solid))),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      controller: passwordController,
      cursorColor: Colors.black45,
      obscureText: true,
      style: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password (Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        //new
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password_outlined, color: Colors.lightBlue),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                  width: 2, style: BorderStyle.solid, color: Colors.blue)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(width: 0, style: BorderStyle.solid))),
    );

    //login field
    final loginButon = Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            loader(context);
            await sigIn(
              emailController.text,
              passwordController.text,
            );
          }
        },
        child: Text(
          "Sign In",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black;
              }
              return Colors.blue;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
      ),
    );

    //google signin buton
    final googleSignIn = Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () async {
          loader(context);
          await getFirebaseMessagingToken();
          await signInWithGoogle(context, loggedInUser, token.toString());
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black87;
              }
              return Colors.black87;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/google.png",
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 10,
              ),
              const Text(
                "Continue with Google",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

    DateTime? currentBackPressTime;

    Future<bool> onWillPop() async {
      // myFocusNode.unfocus();
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: 'Press back again to exit');
        return Future.value(false);
      }
      SystemNavigator.pop(); // add this.

      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            child: Image.asset(
                              "assets/images/logo.png",
                              color: kPColor,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 25),
                          emailField,
                          SizedBox(height: 20),
                          passwordField,
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          loginButon,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                  ),
                                ),
                              ),
                              Text(
                                "OR",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          googleSignIn,
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have a Account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: Text(
                                  "Sign Up ",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

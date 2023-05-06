// ignore_for_file: body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/model/user_model.dart';
import 'package:travel_app/screen/Signin_Signup_Forgot_Screen/login_screen.dart';
import 'package:travel_app/screen/Signin_Signup_Forgot_Screen/verificationScreen.dart';
import 'package:travel_app/utils/loadingIndicator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
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

  //our form key
  final _formKey = GlobalKey<FormState>();
  //editing controller
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmpasswordEditingController = new TextEditingController();
  final photoUrlContainer = new TextEditingController();
  final vehicleTypeController = new TextEditingController();
  final vehicleManufacrureController = new TextEditingController();
  final vehicleColorController = new TextEditingController();
  final licancePlateController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: true,
      controller: firstNameEditingController,
      cursorColor: Colors.black45,
      style: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name can't be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Name (Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        //new
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.account_circle_outlined, color: Colors.lightBlue),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
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

    //last name field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: true,
      cursorColor: Colors.black45,
      style: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Last Name can't be Empty");
        }
        return null;
      },
      onSaved: (value) {
        //new
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.account_circle_outlined, color: Colors.lightBlue),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
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

    //email field
    final emailField = TextFormField(
      autofocus: false,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: true,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail_outline, color: Colors.lightBlue),
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

    //phone number field
    final phoneNumberField = TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      autofocus: false,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: true,
      controller: phoneNumberEditingController,
      cursorColor: Colors.black45,
      style: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
      keyboardType: TextInputType.phone,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{11,}$');
        if (value!.isEmpty) {
          return ("Phone Number can't be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid phone number (Min. 11 Character)");
        }
        return null;
      },
      onSaved: (value) {
        //new
        phoneNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_outlined, color: Colors.lightBlue),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
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
      controller: passwordEditingController,
      style: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
      cursorColor: Colors.black45,
      obscureText: true,
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
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
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

    //confirm password
    final confirmpasswordField = TextFormField(
      autofocus: false,
      enableSuggestions: false,
      autocorrect: false,
      controller: confirmpasswordEditingController,
      style: TextStyle(color: Colors.lightBlue.withOpacity(0.9)),
      cursorColor: Colors.black45,
      obscureText: true,
      validator: (value) {
        if (confirmpasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        //new
        confirmpasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password_outlined, color: Colors.lightBlue),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
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

    //signup button
    final signUpButon = Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: ElevatedButton(
        onPressed: () async {
          await signUp(
              emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
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
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //passing this to a route
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
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
                        height: 100,
                        child: Image.asset(
                          "assets/images/logo.png",
                          color: Colors.blue,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 25),
                      firstNameField,
                      SizedBox(height: 20),
                      lastNameField,
                      SizedBox(height: 20),
                      emailField,
                      SizedBox(height: 20),
                      phoneNumberField,
                      SizedBox(height: 20),
                      passwordField,
                      SizedBox(height: 20),
                      confirmpasswordField,
                      SizedBox(height: 10),
                      signUpButon,
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an account  "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Login ",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
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
      ),
    );
  }

  //signup function
  Future<void> signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      loader(context);
      await getFirebaseMessagingToken();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    //writing all values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = lastNameEditingController.text;
    userModel.phoneNumber = phoneNumberEditingController.text;
    userModel.photoURL = photoUrlContainer.text;
    userModel.role = "User";
    userModel.token = token;
    // userModel.notifications = [];
    await FirebaseAuth.instance.currentUser!
        .updateDisplayName("${firstNameEditingController.text}");
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(
        msg: "Verification mail sent to your account");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
        (route) => false);
  }
}

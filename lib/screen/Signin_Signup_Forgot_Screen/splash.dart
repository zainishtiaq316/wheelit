import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/utils/color_utils.dart';
import '../../model/user_model.dart';
import '../../pages/home_page.dart';
import 'admin.dart';
import 'login_screen.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();
  String? role;
  String? uid;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> isSignedInWithGoogle() async {
    return await _googleSignIn.isSignedIn();
  }

  bool isSignedInWithFirebase() {
    return auth.currentUser != null;
  }

  void checkUID() async {
    bool isSignedInGoogle = await isSignedInWithGoogle();
    bool isSignedInFirebase = isSignedInWithFirebase();

    if (isSignedInGoogle) {
      final acc = await _googleSignIn.signIn();
      final id = acc!.id;
      setState(() {
        uid = id;
      });

      //fetching uid
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {
          uid = loggedInUser.uid;
          role = loggedInUser.role;
        });
      });
    } else if (isSignedInFirebase) {
      final id = auth.currentUser!.uid;
      setState(() {
        uid = id;
      });
      //fetching uid
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {
          uid = loggedInUser.uid;
          role = loggedInUser.role;
        });
      });
    } else {
      print('User is not signed in');
    }
  }

  @override
  void initState() {
    super.initState();
    auth.authStateChanges();
    if (auth.currentUser != null) {
      checkUID();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        nextScreen: auth.currentUser != null
            ? role == "Admin"
                ? Admin(
                    email: loggedInUser.email.toString(),
                  )
                : MyHomePage()
            : LoginScreen(),
        // nextScreen: userRole(),
        splash: Image.asset(
          "assets/images/logo.png",
          color: kPColor,
        ),
        splashIconSize: 250,
        splashTransition: SplashTransition.scaleTransition,
        duration: 1000,
      ),
    );
  }
}

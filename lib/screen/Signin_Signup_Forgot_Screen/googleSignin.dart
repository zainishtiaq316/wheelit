import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/model/notificationModel.dart';
import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/screen/Signin_Signup_Forgot_Screen/admin.dart';

import '../../model/user_model.dart';

Future<UserCredential?> signInWithGoogle(
    BuildContext context, UserModel userModel, String token) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sign in with the credential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Check if the user already exists in Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(googleUser.id)
        .get();

    if (userDoc.exists) {
      // User exists, check their role
      userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      if (userModel.role == "Admin") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Admin(email: "${userModel.email}",)),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);
      }
    } else {
      // User does not exist, create a new user
      userModel.email = googleUser.email;
      userModel.uid = googleUser.id;
      userModel.firstName = googleUser.displayName ?? "";
      userModel.secondName = "";
      userModel.phoneNumber = "";
      userModel.photoURL = googleUser.photoUrl ?? "";
      userModel.role = "User";
      userModel.token = token;
      // userModel.notifications =; // Set this if needed

      await FirebaseFirestore.instance
          .collection("users")
          .doc(googleUser.id)
          .set(userModel.toMap());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (route) => false);
    }

    return userCredential;
  } catch (e) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Something went wrong");
    print("Error on Google SignIn ==> $e");
  }
  return null;
}

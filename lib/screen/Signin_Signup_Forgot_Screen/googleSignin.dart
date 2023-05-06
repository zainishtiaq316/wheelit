import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/model/notificationModel.dart';
import 'package:travel_app/pages/home_page.dart';

import '../../model/user_model.dart';

Future<UserCredential?> signInWithGoogle(
    BuildContext context, UserModel userModel,String token) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() async {
  
      userModel.email = googleUser!.email;
      userModel.uid = googleUser.id;
      userModel.firstName = googleUser.displayName;
      userModel.secondName = "";
      userModel.phoneNumber = "";
      userModel.photoURL = googleUser.photoUrl;
      userModel.role = "User";
      userModel.token = token;
      // userModel.notifications =;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(googleUser.id)
          .set(userModel.toMap());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (route) => false);
    });
  } catch (e) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Something went wrong");
    print("Error on google Signin ==> $e");
  }
  return null;
}

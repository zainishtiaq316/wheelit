import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/utils/color_utils.dart';

import '../../model/user_model.dart';

class UserNotifications extends StatefulWidget {
  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  final auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();
  String? uid;
  // List<Map<String, dynamic>> dataList = [];
  final dataList = [];

// Create instances of FirebaseAuth and GoogleSignIn
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

// Method to check if the user is signed in with Google Sign-In
  Future<bool> isSignedInWithGoogle() async {
    return await _googleSignIn.isSignedIn();
  }

// Method to check if the user is signed in with Firebase Auth
  bool isSignedInWithFirebase() {
    return _auth.currentUser != null;
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
        });
      });
    } else {
      print('User is not signed in');
    }
  }

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Notifications")
        .doc(auth.currentUser!.uid)
        .collection("Notifications")
        .get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      setState(() {
        dataList.add(data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // checkUID();
    // print("user UID ${uid}");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPColor,
          title: Text(
            "Notifications",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: dataList.isEmpty
            ? Center(
                child: Text("No Notifications"),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Notifications")
                    .doc(auth.currentUser!.uid)
                    .collection("Notifications")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kPColor,
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var dt = DateTime.fromMillisecondsSinceEpoch(
                            int.parse(dataList[index]['id']));
                        var dateTime =
                            DateFormat('EEEE, MMMd, hh:mm a').format(dt);
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(1, 1),
                                    color: black.withOpacity(0.1),
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                dataList[index]['title'].toString(),
                                style: GoogleFonts.montserrat(
                                    color: black, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4.0),
                                  Text(dataList[index]['message'].toString()),
                                  const SizedBox(height: 15),
                                  Text(dateTime.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: kPColor,
                      ),
                    );
                    // return Center(
                    //   child: Text("No Notifications"),
                    // );
                  }
                },
              ));
  }
}

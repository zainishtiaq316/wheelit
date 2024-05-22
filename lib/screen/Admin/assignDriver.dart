import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/utils/loadingIndicator.dart';

import '../../utils/color_utils.dart';
import '../../widgets/notificationFunction.dart';

import 'adminBN.dart';

class DriverAssign extends StatefulWidget {
  const DriverAssign(
      {super.key,
      required this.name,
      required this.contact,
      required this.email,
      required this.source,
      required this.destination,
      required this.startDate,
      required this.endDate,
      required this.uid,
      required this.userToken,
      required this.imagePath,
      required this.id});

  final String id;
  final String name;
  final String contact;
  final String email;
  final String source;
  final String destination;
  final String startDate;
  final String endDate;
  final String uid;
  final String userToken;
  final String imagePath;

  @override
  State<DriverAssign> createState() => _DriverAssignState();
}

class _DriverAssignState extends State<DriverAssign> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  Future<void> uplaodConfirmedTour(
      String id,
      String userId,
      String name,
      String email,
      String contact,
      String userToken,
      String source,
      String destination,
      String startDate,
      String endDate,
      String imagePath) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    // final image = FirebaseAuth.instance.currentUser!.photoURL;
    await FirebaseFirestore.instance
        .collection("ConfirmedTours")
        .doc(userId)
        .collection("Booked")
        .doc(id)
        .set({
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
      'source': source,
      'destination': destination,
      'startDate': startDate,
      'endDate': endDate,
      'userId': userId,
      'userToken': userToken,
      'userImage': imagePath,
    });
  }

  Future<void> allConfirmedBookings(
      String id,
      String userId,
      String name,
      String email,
      String contact,
      String userToken,
      String source,
      String destination,
      String startDate,
      String endDate,
      String imagePath) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    // final image = FirebaseAuth.instance.currentUser!.photoURL;
    await FirebaseFirestore.instance.collection("AllBookings").doc(id).set({
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
      'source': source,
      'destination': destination,
      'startDate': startDate,
      'endDate': endDate,
      'userId': userId,
      'userToken': userToken,
      'userImage': imagePath,
    });
  }

  // Future<void> uplaodConfirmedTour(
  //     String userId,
  //     String name,
  //     String email,
  //     String contact,
  //     String userToken,
  //     String source,
  //     String destination,
  //     String startDate,
  //     String endDate,
  //     String imagePath) async {
  //   // final uid = FirebaseAuth.instance.currentUser!.uid;
  //   // final image = FirebaseAuth.instance.currentUser!.photoURL;
  //   await FirebaseFirestore.instance
  //       .collection("ConfirmedTours")
  //       .doc(userId)
  //       .collection("Booked")
  //       .add({
  //     'name': name,
  //     'contact': contact,
  //     'email': email,
  //     'source': source,
  //     'destination': destination,
  //     'startDate': startDate,
  //     'endDate': endDate,
  //     'userId': userId,
  //     'userToken': userToken,
  //     'userImage': imagePath,
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    contactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPColor,
        centerTitle: true,
        title: Text(
          "Assign Driver",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                autofocus: false,
                obscureText: false,
                enableSuggestions: true,
                autocorrect: true,
                controller: nameController,
                cursorColor: Colors.black45,
                style: TextStyle(color: black),
                keyboardType: TextInputType.name,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{3,}$');
                  if (value!.isEmpty) {
                    return ("Name can't be Empty");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid Name (Min. 3 Character)");
                  }
                  return null;
                },
                onSaved: (value) {
                  //new
                  nameController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    suffixIcon: null,
                    prefixIcon: Icon(Icons.person, color: kPColor),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Driver Name",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: white.withOpacity(0.3),
                    hintStyle: TextStyle(color: black),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                autofocus: false,
                obscureText: false,
                enableSuggestions: true,
                autocorrect: true,
                controller: contactController,
                cursorColor: Colors.black45,
                style: TextStyle(color: black),
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
                  contactController.text = value!;
                },
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    suffixIcon: null,
                    prefixIcon: Icon(Icons.phone_outlined, color: kPColor),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Driver Phone Number",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: white.withOpacity(0.3),
                    hintStyle: TextStyle(color: black),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid))),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final contact = contactController.text.trim();
                  // final userId = FirebaseAuth.instance.currentUser!.uid;

                  if (formkey.currentState!.validate()) {
                    loader(context);
                    await uplaodConfirmedTour(
                      widget.id,
                      widget.uid,
                      name,
                      widget.email,
                      contact,
                      widget.userToken,
                      widget.source,
                      widget.destination,
                      widget.startDate,
                      widget.endDate,
                      widget.imagePath,
                    );

                    await allConfirmedBookings(
                        widget.id,
                        widget.uid,
                        name,
                        widget.email,
                        contact,
                        widget.userToken,
                        widget.source,
                        widget.destination,
                        widget.startDate,
                        widget.endDate,
                        widget.imagePath);

                    try {
                      await sendPushNotification(
                          widget.userToken,
                          "Wheet it Admin",
                          "Your tour request from ${widget.source} to ${widget.destination} has been accepted!");
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Notification not sent");
                    }

                    await addNotifications(
                        widget.uid,
                        DateTime.now().millisecondsSinceEpoch.toString(),
                        "From admin",
                        "Your tour request from ${widget.source} to ${widget.destination} has been accepted!");

                    await FirebaseFirestore.instance
                        .collection("JoinRequests")
                        .doc(widget.id)
                        .delete();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminBottomNav()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPColor,
                  elevation: 0,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 100,
                  ),
                ),
                child: Text("Confirm Tour",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      color: white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

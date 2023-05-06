import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/utils/loadingIndicator.dart';

import '../../utils/color_utils.dart';
import '../../widgets/notificationFunction.dart';
import '../../widgets/textFormField.dart';
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
        title: Text(
          "Assign Driver",
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
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Textformfield(
              keyboard: TextInputType.text,
              hintText: "Driver Name",
              obsecure: false,
              controller: nameController,
              validator: (v) {
                if (v!.isEmpty) {
                  return "field required";
                }
                return null;
              },
              suffixicon: null,
              prefixicon: Icon(
                Icons.person,
                color: kPColor,
              ),
            ),
            Textformfield(
              keyboard: TextInputType.number,
              formatterList: <TextInputFormatter>[],
              hintText: "Driver Phone no",
              obsecure: false,
              controller: contactController,
              validator: (v) {
                if (v!.isEmpty) {
                  return "field required";
                }
                return null;
              },
              suffixicon: null,
              prefixicon: Icon(
                Icons.phone,
                color: kPColor,
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/joinModel.dart';
import 'package:travel_app/screen/Admin/adminBN.dart';
import 'package:travel_app/utils/assureDialog.dart';
import 'package:travel_app/utils/loadingIndicator.dart';

import '../../utils/color_utils.dart';
import '../../widgets/notificationFunction.dart';
import 'assignDriver.dart';

class TourDetails extends StatefulWidget {
  const TourDetails({super.key, required this.joinModel});

  final JoinModel joinModel;

  @override
  State<TourDetails> createState() => _TourDetailsState();
}

class _TourDetailsState extends State<TourDetails> {
  @override
  Widget build(BuildContext context) {
    // DocumentReference confirmedDocumentRef = FirebaseFirestore.instance
    //     .collection("ConfirmedTours")
    //     .doc(joinModel.userId)
    //     .collection("Booked")
    //     .doc(joinModel.id);

    DocumentReference documentRef = FirebaseFirestore.instance
        .collection("JoinRequests")
        .doc(widget.joinModel.id);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPColor,
        title: Text(
          "Tour Details",
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
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name:",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.joinModel.name,
                  style: GoogleFonts.openSans(
                    color: black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone no:",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.joinModel.contact,
                  style: GoogleFonts.openSans(
                    color: black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email:",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.joinModel.email,
                  style: GoogleFonts.openSans(
                    color: black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Divider(
              thickness: 1,
              color: black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Source Point:',
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.joinModel.source,
                  style: GoogleFonts.openSans(
                    color: black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Destination Point:',
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.joinModel.destination,
                  style: GoogleFonts.openSans(
                    color: black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Divider(
              thickness: 1,
              color: black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Departure:",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.joinModel.startDate,
                  style: GoogleFonts.openSans(
                    color: black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Arrival:",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.joinModel.endDate,
                  style: GoogleFonts.openSans(
                    color: black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 50.0),
          Spacer(),
          // documentRef.id == confirmedDocumentRef.id
          // widget.joinModel.id == confirmedDocumentRef.id ?
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DriverAssign(
                            id: widget.joinModel.id,
                            name: widget.joinModel.name,
                            contact: widget.joinModel.contact,
                            email: widget.joinModel.email,
                            source: widget.joinModel.source,
                            destination: widget.joinModel.destination,
                            startDate: widget.joinModel.startDate,
                            endDate: widget.joinModel.endDate,
                            uid: widget.joinModel.userId,
                            userToken: widget.joinModel.userToken,
                            imagePath: widget.joinModel.userImage)));
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 100,
                ),
              ),
              child: Text("Accept",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    color: white,
                  )),
            ),
          ),
          // : SizedBox.shrink(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                assuranceDialog(context, () async {
                  loader(context);

                  await sendPushNotification(
                      widget.joinModel.userToken,
                      "Wheet it Admin",
                      "Your tour request from ${widget.joinModel.source} to ${widget.joinModel.destination} has been Rejected!");

                  await addNotifications(
                      widget.joinModel.userId,
                      DateTime.now().millisecondsSinceEpoch.toString(),
                      "From admin",
                      "Your tour request from ${widget.joinModel.source} to ${widget.joinModel.destination} has been Rejected!");

                  await documentRef.delete();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminBottomNav()));
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 100,
                ),
              ),
              child: Text("Reject",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    color: white,
                  )),
            ),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/joinModel.dart';
import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/utils/assureDialog.dart';
import 'package:travel_app/utils/loadingIndicator.dart';
import '../../utils/color_utils.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key, required this.joinModel});

  final JoinModel joinModel;

  @override
  Widget build(BuildContext context) {
    DocumentReference confirmedDocumentRef = FirebaseFirestore.instance
        .collection("ConfirmedTours")
        .doc(joinModel.userId)
        .collection("Booked")
        .doc(joinModel.id);

    DocumentReference deleteFromAllBookings =
        FirebaseFirestore.instance.collection("AllBookings").doc(joinModel.id);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPColor,
        title: Text(
          "Booking Details",
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
                  "Driver Name:",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  joinModel.name,
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
                  "Driver Phone no:",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  joinModel.contact,
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
                  joinModel.source,
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
                  joinModel.destination,
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
                  "Depart: ",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  joinModel.startDate,
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
                  "Arr: ",
                  style: GoogleFonts.openSans(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  joinModel.endDate,
                  style: GoogleFonts.openSans(
                    color: black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                assuranceDialog(context, () async {
                  loader(context);
                  await deleteFromAllBookings.delete();
                  await confirmedDocumentRef.delete().whenComplete(() {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  });
                  Fluttertoast.showToast(msg: "Tour Cancelled");
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 50,
                ),
              ),
              child: Text("Cancel Tour",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    color: white,
                  )),
            ),
          ),
          const SizedBox(height: 50.0)
        ],
      ),
    );
  }
}

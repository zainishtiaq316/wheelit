import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/joinModel.dart';
import '../../utils/color_utils.dart';

class AllBookingsDetails extends StatefulWidget {
  const AllBookingsDetails({super.key, required this.joinModel});

  final JoinModel joinModel;

  @override
  State<AllBookingsDetails> createState() => _AllBookingsDetailsState();
}

class _AllBookingsDetailsState extends State<AllBookingsDetails> {
  @override
  Widget build(BuildContext context) {
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
                  "Driver Name:",
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
                  "Driver Phone no:",
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Email:",
          //         style: GoogleFonts.openSans(
          //             fontSize: 20, color: black, fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         widget.joinModel.email,
          //         style: GoogleFonts.openSans(
          //           color: black,
          //           fontSize: 20,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
        ],
      ),
    );
  }
}

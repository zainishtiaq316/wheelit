// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/screen/Admin/tourRequests.dart';
import 'package:travel_app/utils/color_utils.dart';

import 'allBookings.dart';

class AdminHome extends StatelessWidget {
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async {
    // myFocusNode.unfocus();
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to exit');
      return Future.value(false);
    }
    SystemNavigator.pop(); // add this.

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPColor,
            title: Row(
              children: [
                Image.asset(
                  "assets/images/logo Icon.png",
                  color: black,
                  height: 25,
                ),
                const SizedBox(width: 10.0),
                Text(
                  "WHEEL IT",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TourRequests()));
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: kPColor.withOpacity(0.75),
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, 1),
                            color: black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Center(
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/destination (1).png",
                        height: 35,
                      ),
                      title: Text(
                        "Tour Requests",
                        style: GoogleFonts.openSans(color: black, fontSize: 20),
                      ),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllBookings()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: kPColor.withOpacity(0.75),
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, 1),
                            color: black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Center(
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/destination (1).png",
                        height: 35,
                      ),
                      title: Text(
                        "All Bookings",
                        style: GoogleFonts.openSans(color: black, fontSize: 20),
                      ),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

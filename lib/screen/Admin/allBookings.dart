import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/screen/Admin/allBookingDetails.dart';
import '../../model/joinModel.dart';
import '../../utils/color_utils.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({super.key});

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  List<Map<String, dynamic>> dataList = [];

  void getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('AllBookings').get();

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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPColor,
        centerTitle: true,
        title: Text(
          "All Bookings",
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
      body: dataList.isEmpty
          // ? Center(
          //     child: CircularProgressIndicator(
          //     color: kPColor,
          //   ))
          ? Center(
              child: Text(
                "No Bookings",
                style: GoogleFonts.openSans(
                  color: black,
                ),
              ),
            )
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final list = dataList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllBookingsDetails(
                                  joinModel: JoinModel(
                                    id: list['id'] ?? "",
                                    name: list['name'],
                                    contact: list['contact'],
                                    email: list['email'],
                                    source: list['source'],
                                    destination: list['destination'],
                                    startDate: list['startDate'],
                                    endDate: list['endDate'],
                                    userId: list['userId'],
                                    userImage: list['userImage'],
                                    userToken: list['userToken'],
                                  ),
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    // height: MediaQuery.of(context).size.height * 0.05,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: black.withOpacity(0.1))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: GoogleFonts.openSans(
                                      color: black,
                                    ),
                                    children: [
                                  TextSpan(
                                    text: 'Tour from ',
                                    style: GoogleFonts.openSans(color: black),
                                  ),
                                  TextSpan(
                                    text: list['source'],
                                    style: GoogleFonts.openSans(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' to ',
                                    style: GoogleFonts.openSans(color: black),
                                  ),
                                  TextSpan(
                                    text: list['destination'],
                                    style: GoogleFonts.openSans(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                            Icon(CupertinoIcons.forward)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

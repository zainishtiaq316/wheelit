import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/model/joinModel.dart';
import 'package:travel_app/utils/color_utils.dart';

import 'bookingDetails.dart';

class BookingScreen extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot> getBookedToursStream() {
    return FirebaseFirestore.instance
        .collection("ConfirmedTours")
        .doc(userId)
        .collection("Booked")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPColor,
          automaticallyImplyLeading: false,
          title: Center(child: Text('Booked Trip')),
        ),
        body: StreamBuilder(
            stream: getBookedToursStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // final List<String> favoriteIds = snapshot.data!.docs
                //     .map((doc) => doc['itemName'] as String)
                //     .toList();

                final booked = snapshot.data!.docs
                    .map((doc) => doc.data() as dynamic)
                    .toList();
                // Map<String, dynamic> booked =
                //     snapshot.data! as Map<String, dynamic>;

                // print(favorites);
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: booked.length,
                  itemBuilder: (context, index) {
                    final list = booked[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingDetails(
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
                                            userToken: list['userToken'],
                                            userImage: list['userImage']))));
                          },
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(list['userImage']),
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                title: Text(
                                  list['destination'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    'Trip Schedule :  ${list['startDate']} to ${list['endDate']}'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

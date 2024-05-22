// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/model/recommended_places_model.dart';
import 'package:travel_app/utils/color_utils.dart';
import 'package:travel_app/utils/loadingIndicator.dart';

import '../screen/Booking_Screen/jointour.dart';
import '../widgets/favButton.dart';

class TouristDetailsPage extends StatefulWidget {
  TouristDetailsPage({Key? key, required this.data
      // ,this.name
      })
      : super(key: key);

  final RecommendedPlaceModel data;
  // String? name;

  @override
  State<TouristDetailsPage> createState() => _TouristDetailsPageState();
}

class _TouristDetailsPageState extends State<TouristDetailsPage> {
  double rating = 0;
  final ratingsCollection = FirebaseFirestore.instance.collection('ratings');
  final favCollection = FirebaseFirestore.instance.collection("Favorite");

  void showratingDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Rate this tour"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   "Please leave a star rating",
              //   style: TextStyle(fontSize: 20),
              // ),
              // const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  // allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  onRatingUpdate: (value) {
                    rating = value;
                    print(rating);
                    setState(() {
                      rating = value;
                    });
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  loader(context);
                  // Get the current user ID
                  final userId = FirebaseAuth.instance.currentUser!.uid;

                  // Add a new rating to Firestore
                  // await ratingsCollection.doc(userId).set({
                  //   'itemName': widget.data.name,
                  //   'userId': userId,
                  //   'rating': rating,
                  // });
                  await ratingsCollection.add({
                    'itemName': widget.data.name,
                    'userId': userId,
                    'rating': rating,
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Show a success message
                  Fluttertoast.showToast(msg: "Rating Submitted");
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(
              height: size.height * 0.38,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage(widget.data.image),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(15)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Ionicons.chevron_back),
                          ),
                          ItemFavoriteButton(model: widget.data)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.data.distance,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => showratingDialog(context),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kPColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    "Rate this tour",
                                    style: TextStyle(color: white),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow.shade700,
                              // size: 14,
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('ratings')
                                  .where('itemName',
                                      isEqualTo: widget.data.name)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final ratings = snapshot.data!.docs;
                                  final numRatings = ratings.length;
                                  final totalRating =
                                      ratings.fold(0, (num sum, rating) {
                                    return sum + rating['rating'];
                                  });

                                  final avgRating = numRatings > 0
                                      ? totalRating / numRatings
                                      : 0;
                                  return Text(
                                      '${avgRating.toStringAsFixed(1)}');
                                } else {
                                  return Text('Loading...');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.data.time,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Started in",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              height: 180,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                image: const DecorationImage(
                  image: AssetImage('assets/places/map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JoinTour(
                            dataClass: widget.data,
                          )),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: kPColor,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 8.0,
                  ),
                  textStyle: Theme.of(context).typography.dense.bodyLarge,
                ),
                child: const Text("Join this tour"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

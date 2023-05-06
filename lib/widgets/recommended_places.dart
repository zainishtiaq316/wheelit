import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/model/recommended_places_model.dart';
import 'package:travel_app/pages/tourist_details_page.dart';

class RecommendedPlaces extends StatefulWidget {
  const RecommendedPlaces({Key? key}) : super(key: key);

  @override
  State<RecommendedPlaces> createState() => _RecommendedPlacesState();
}

class _RecommendedPlacesState extends State<RecommendedPlaces> {


  @override
  Widget build(BuildContext context) => SizedBox(
        height: 235,
        child: ListView.separated(
          itemCount: 9,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SizedBox(
            width: 220,
            child: Card(
              elevation: 0.4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TouristDetailsPage(
                        data: recommendedPlacesList[index],
                      ),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          recommendedPlacesList[index].image,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            recommendedPlacesList[index].name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                            // size: 14,
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('ratings')
                                .where('itemName',
                                    isEqualTo:
                                        recommendedPlacesList[index].name)
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
                                return Text('${avgRating.toStringAsFixed(1)}');
                              } else {
                                return Text('Loading...');
                              }
                            },
                          ),
                          // Text(
                          //   recommendedPlacesList[index].rating,
                          //   style: TextStyle(
                          //       // fontSize: 12,
                          //       ),
                          // ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Ionicons.location,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            recommendedPlacesList[index].location,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
        ),
      );
}

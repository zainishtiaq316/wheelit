import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/pages/tourist_details_page.dart';
import '../model/recommended_places_model.dart';

// ignore: must_be_immutable
class NearbyPlaces extends StatefulWidget {
  NearbyPlaces({required this.modelList});

  List<RecommendedPlaceModel> modelList;

  @override
  State<NearbyPlaces> createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  @override
  void initState() {
    super.initState();
    widget.modelList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.modelList.length, (index) {
        final list = widget.modelList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            height: 135,
            width: double.maxFinite,
            child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TouristDetailsPage(
                          data: list,
                        ),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          list.image,
                          height: double.maxFinite,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(list.location),
                            const SizedBox(height: 10),
                            // DISTANCE WIDGET
                            Row(
                              children: [
                                const Icon(
                                  Ionicons.locate_outline,
                                  color: Colors.black54,
                                  size: 14,
                                ),
                                const Text(
                                  "Accra",
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                ...List.generate(
                                  18,
                                  (index) {
                                    return Expanded(
                                      child: Container(
                                        height: 2,
                                        color: index.isOdd
                                            ? Colors.transparent
                                            : Colors.black54,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 3),
                                Icon(
                                  Ionicons.location_outline,
                                  size: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  list.slocation,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                  size: 14,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('ratings')
                                      .where('itemName', isEqualTo: list.name)
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
                                const Spacer(),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    text: list.price,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

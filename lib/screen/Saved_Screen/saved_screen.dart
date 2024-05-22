import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/recommended_places_model.dart';
import '../../pages/tourist_details_page.dart';
import '../../utils/color_utils.dart';

class SavedScreen extends StatefulWidget {
  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  Stream<QuerySnapshot> getFavoritesStream() {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('favorites')
        .doc(userId)
        .collection('items')
        // .orderBy('createdAt', descending: true)
        .snapshots();

  }

 DateTime? currentBackPressTime;

    late FocusNode myFocusNode;

   Future<bool> onWillPop() async {
    // myFocusNode.unfocus();
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to exit');
      setState(() {
        myFocusNode.unfocus();
      });
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
          backgroundColor: kPColor,
          automaticallyImplyLeading: false,
          title: Center(child: Text('Saved Trips')),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: getFavoritesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // final List<String> favoriteIds = snapshot.data!.docs
              //     .map((doc) => doc['itemName'] as String)
              //     .toList();
    
              final favorites = snapshot.data!.docs
                  .map((doc) => doc.data() as dynamic)
                  .toList();
    
              // print(favorites);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return TripCard(
                    detailsPage: TouristDetailsPage(
                        data: RecommendedPlaceModel(
                            image: item['image'] as String,
                            rating: item['rating'] as String,
                            location: item['location'] as String,
                            name: item['name'] as String,
                            price: item['price'] as String,
                            distance: item['distance'] as String,
                            time: item['time'] as String,
                            slocation: item['slocation'] as String)),
                    // detailsPage: SizedBox.shrink(),
                    location: item['location'] as String,
                    name: item['name'] as String,
                    imageUrl: item['image'] as String,
                    // imageUrl: itemName.contains("Naran")
                    //     ? "assets/places/place10.jpg"
                    //     : itemName.contains("Murree")
                    //         ? "assets/places/place8.jpg"
                    //         : itemName.contains("Rohtas Fort")
                    //             ? "assets/places/place9.jpg"
                    //             : itemName.contains("Daman-e-Koh")
                    //                 ? "assets/places/place5.jpg"
                    //                 : itemName.contains("Minar e Pakistan")
                    //                     ? "assets/places/place4.jpg"
                    //                     : itemName.contains("Neelum Valley")
                    //                         ? "assets/places/place2.jpg"
                    //                         : "assets/places/place2.jpg",
                    height: 230,
                    width: 500,
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
          },
        ),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final String location;
  final String name;
  final String imageUrl;
  final double width;
  final double height;
  final Widget detailsPage;

  TripCard(
      {required this.location,
      required this.name,
      required this.imageUrl,
      required this.detailsPage,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => detailsPage));
          },
          child: Column(
            children: [
              Image(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(
                  '$name',
                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.location_on),
                subtitle: Text(location),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

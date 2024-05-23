import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_app/model/recommended_places_model.dart';
import 'package:travel_app/model/user_model.dart';
import '../../utils/color_utils.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/nearby_places.dart';
import '../../widgets/recommended_places.dart';
import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late FocusNode myFocusNode;
  final searchController = TextEditingController();
  String firstName = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      // myFocusNode.hasFocus;
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  List<RecommendedPlaceModel> allData = recommendedPlacesList;
  List<RecommendedPlaceModel> filteredNames = [];

  void searchFromList(String value) {
    setState(() {
      filteredNames = allData.where((name) {
        return name.name.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }
 Future<void> fetchUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // Extract user data
    setState(() {
      firstName = userData.data()?['firstName'];
     
    });
  }
 
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    myFocusNode.dispose();
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async {
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
      child: GestureDetector(
        onTap: () {
          setState(() {
            myFocusNode.unfocus();
          });
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            titleSpacing: 8,
            title: Row(
              children: [
                Image.asset(
                  "assets/images/logo Icon.png",
                  color: kPColor,
                  height: 25,
                ),
                const SizedBox(width: 5.0),
                Text(
                  "WHEEL IT",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, color: kPColor),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 12),
                child: CustomIconButton(
                  onpress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserNotifications()));
                  },
                  icon: Icon(Ionicons.notifications_outline),
                ),
              ),
            ],
          ),
          body: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hi, ",
                          style: GoogleFonts.montserrat(
                              color: black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${firstName}",
                          style: GoogleFonts.montserrat(
                              color: black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Explore Places For Your Tour",
                      style: GoogleFonts.montserrat(
                          color: black.withOpacity(0.7),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: searchController,
                          onChanged: (value) {
                            searchFromList(value);
                          },
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              searchFromList(value);
                            }
                          },
                          focusNode: myFocusNode,
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintText: "Search",
                              suffixIcon: const Icon(CupertinoIcons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide())),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // CATEGORIES
                    myFocusNode.hasFocus
                        ? SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recommendation",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                    myFocusNode.hasFocus ? SizedBox.shrink() : SizedBox(height: 10),
                    myFocusNode.hasFocus ? SizedBox.shrink() : RecommendedPlaces(),
                    myFocusNode.hasFocus ? SizedBox.shrink() : SizedBox(height: 10),
                    myFocusNode.hasFocus
                        ? SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nearby From You",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                    const SizedBox(height: 10),
                    NearbyPlaces(
                        modelList: myFocusNode.hasFocus
                            ? filteredNames
                            : recommendedPlacesList)
                  ],
                )
),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/model/recommended_places_model.dart';
import 'package:travel_app/utils/color_utils.dart';
import 'package:travel_app/utils/loadingIndicator.dart';

import '../../model/user_model.dart';

class JoinTour extends StatefulWidget {
  JoinTour({super.key, required this.dataClass});

  final RecommendedPlaceModel dataClass;

  @override
  State<JoinTour> createState() => _JoinTourState();
}

class _JoinTourState extends State<JoinTour> {
  bool isCashOnDelivery = true;
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final sourcePointController = TextEditingController();
  final desController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();
  String? uid;
  String? userToken;

// Create instances of FirebaseAuth and GoogleSignIn
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

// Method to check if the user is signed in with Google Sign-In
  Future<bool> isSignedInWithGoogle() async {
    return await _googleSignIn.isSignedIn();
  }

// Method to check if the user is signed in with Firebase Auth
  bool isSignedInWithFirebase() {
    return _auth.currentUser != null;
  }

// Usage example
  void checkAuthentication() async {
    bool isSignedInGoogle = await isSignedInWithGoogle();
    bool isSignedInFirebase = isSignedInWithFirebase();

    if (isSignedInGoogle) {
      final acc = await _googleSignIn.signIn();
      final id = acc!.id;
      setState(() {
        uid = id;
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {
          userToken = loggedInUser.token;
        });
      });
      print('User is signed in with Google Sign-In');
    } else if (isSignedInFirebase) {
      final id = auth.currentUser!.uid;
      setState(() {
        uid = id;
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {
          userToken = loggedInUser.token;
        });
        nameController.text =
            '${loggedInUser.firstName} ${loggedInUser.secondName}';
        emailController.text = loggedInUser.email!;
        contactController.text = loggedInUser.phoneNumber!;
      });
      print('User is signed in with Firebase Auth');
    } else {
      print('User is not signed in');
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  // UserModel loggedInUser = UserModel();
  // String? userToken;

  // @override
  // void initState() {
  //   super.initState();

  // FirebaseFirestore.instance
  //     .collection("users")
  //     .doc(FirebaseAuth.instance.currentUser!.uid == null ? : )
  //     .get()
  //     .then((value) {
  //   this.loggedInUser = UserModel.fromMap(value.data());
  //   setState(() {
  //     userToken = loggedInUser.token;
  //   });
  // });
  // }

  DateTime? _selectedDateTime;
  String? formattedDateTime;
  DateTime? _endDateTime;
  String? endedDateFromattingDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
          formattedDateTime =
              DateFormat('MMM d yyyy, h:mm a').format(_selectedDateTime!);
        });
      }
    }
  }

  Future<void> _selectEndDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTime != null) {
        setState(() {
          _endDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
          endedDateFromattingDateTime =
              DateFormat('MMM d yyyy, h:mm a').format(_endDateTime!);
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    sourcePointController.dispose();
    desController.dispose();
    // dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Tour"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  readOnly: true,
                  autofocus: false,
                  obscureText: false,
                  enableSuggestions: true,
                  autocorrect: true,
                  controller: nameController,
                  cursorColor: Colors.black45,
                  style: TextStyle(color: black),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("Name can't be Empty");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Name (Min. 3 Character)");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //new
                    nameController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      suffixIcon: null,
                      prefixIcon:
                          Icon(Icons.account_circle_outlined, color: kPColor),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Name",
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: white.withOpacity(0.3),
                      hintStyle: TextStyle(color: black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  readOnly: true,
                  autofocus: false,
                  obscureText: false,
                  enableSuggestions: true,
                  autocorrect: true,
                  controller: contactController,
                  cursorColor: Colors.black45,
                  style: TextStyle(color: black),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{11,}$');
                    if (value!.isEmpty) {
                      return ("Phone Number can't be Empty");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid phone number (Min. 11 Character)");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //new
                    contactController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      suffixIcon: null,
                      prefixIcon: Icon(Icons.phone_outlined, color: kPColor),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Phone Number",
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: white.withOpacity(0.3),
                      hintStyle: TextStyle(color: black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  readOnly: true,
                  autofocus: false,
                  obscureText: false,
                  enableSuggestions: true,
                  autocorrect: true,
                  controller: emailController,
                  cursorColor: Colors.black45,
                  style: TextStyle(color: black),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    //reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //new
                    emailController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      suffixIcon: null,
                      prefixIcon: Icon(Icons.mail_outline, color: kPColor),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Email",
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: white.withOpacity(0.3),
                      hintStyle: TextStyle(color: black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  autofocus: false,
                  obscureText: false,
                  enableSuggestions: true,
                  autocorrect: true,
                  controller: sourcePointController,
                  cursorColor: Colors.black45,
                  style: TextStyle(color: black),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{4,}$');
                    if (value!.isEmpty) {
                      return ("Source Point can't be Empty");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Source Point");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //new
                    sourcePointController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      suffix: null,
                      prefixIcon: Icon(Icons.location_on, color: kPColor),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Source Point",
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: white.withOpacity(0.3),
                      hintStyle: TextStyle(color: black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  readOnly: true,
                  autofocus: false,
                  enableSuggestions: true,
                  autocorrect: true,
                  cursorColor: Colors.black45,
                  style: TextStyle(color: kPColor),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: kPColor,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: widget.dataClass.name,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: white.withOpacity(0.3),
                      hintStyle: TextStyle(color: black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "field required";
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () => _selectDateTime(context),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range, color: kPColor),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: white.withOpacity(0.3),
                      hintStyle: TextStyle(color: black),
                      hintText: "Start date",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: kPColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid))),
                  controller: formattedDateTime != null
                      ? TextEditingController(text: formattedDateTime)
                      : null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "field required";
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () => _selectEndDateTime(context),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range, color: kPColor),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: white.withOpacity(0.3),
                      hintStyle: TextStyle(color: black),
                      hintText: "End date",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid))),
                  controller: endedDateFromattingDateTime != null
                      ? TextEditingController(text: endedDateFromattingDateTime)
                      : null,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Payment in cash",
              //         style:
              //             GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              //       ),
              //       Switch(
              //           // activeColor: light,
              //           // activeTrackColor: dark,
              //           // inactiveThumbColor: dark.withOpacity(0.5),
              //           // inactiveTrackColor: dark.withOpacity(0.1),
              //           value: isCashOnDelivery,
              //           onChanged: (value) {
              //             setState(() {
              //               isCashOnDelivery = value;
              //             });
              //           }),
              //     ],
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   height: MediaQuery.of(context).size.height * 0.07,
              //   decoration: BoxDecoration(
              //       border: Border.all(),
              //       // color: black.withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(15)),
              //   child: Center(
              //     child:
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListTile(
                  title: Text("Payment in cash"),
                  trailing: Switch(
                      value: isCashOnDelivery,
                      onChanged: (value) {
                        setState(() {
                          isCashOnDelivery = true;
                        });
                      }),
                ),
              ),
              //   ),
              // ),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text;
                  final email = emailController.text;
                  final contact = contactController.text;
                  final sourcePoint = sourcePointController.text;
                  final startDate = formattedDateTime;
                  final endDate = endedDateFromattingDateTime;

                  if (formKey.currentState!.validate()) {
                    loader(context);
                    await joinUplaod(
                            DateTime.now().millisecondsSinceEpoch.toString(),
                            name,
                            email,
                            contact,
                            userToken!,
                            sourcePoint,
                            widget.dataClass.name,
                            startDate!,
                            endDate!,
                            widget.dataClass.image)
                        .whenComplete(() {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Your request is pending"),
                            content:
                                Text("Stay tuned with us for latest updates"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: kPColor),
                                  ))
                            ],
                          );
                        },
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 50.0,
                  ),
                ),
                child: const Text("Book Tour"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> joinUplaod(
    String id,
    String name,
    String email,
    String contact,
    String userToken,
    String source,
    String destination,
    String startDate,
    String endDate,
    String image) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  // final image = FirebaseAuth.instance.currentUser!.photoURL;
  await FirebaseFirestore.instance.collection("JoinRequests").doc(id).set({
    'id': id,
    'name': name,
    'contact': contact,
    'email': email,
    'source': source,
    'destination': destination,
    'startDate': startDate,
    'endDate': endDate,
    'userId': uid,
    'userToken': userToken,
    'userImage': image,
  });
}

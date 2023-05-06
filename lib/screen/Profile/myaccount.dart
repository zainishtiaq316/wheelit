import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_utils.dart';

class AccountInfo extends StatefulWidget {
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final user = FirebaseAuth.instance.currentUser;
  // final auth = FirebaseAuth.instance;
  // UserModel loggedInUser = UserModel();

  // @override
  // void initState() {
  //   super.initState();

  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(auth.currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       this.loggedInUser = UserModel.fromMap(value.data());
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPColor,
        title: Text(
          "ACCOUNT",
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
        children: [
          SizedBox(
            height: 20,
          ),
          // loggedInUser.firstName != null
          //     ?
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name:',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${user!.displayName}",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.7),
                  ),
                )
              ],
            ),
          )
          // : SizedBox.shrink(),
          // loggedInUser.secondName != null
          //     ? Padding(
          //         padding:
          //             const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               'Last Name:',
          //               style: GoogleFonts.lato(
          //                   fontSize: 20,
          //                   color: Colors.black.withOpacity(0.7),
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             Text(
          //               "${loggedInUser.secondName}",
          //               style: GoogleFonts.lato(
          //                 fontSize: 20,
          //                 color: Colors.black.withOpacity(0.7),
          //               ),
          //             )
          //           ],
          //         ),
          //       )
          //     : SizedBox.shrink(),
          // loggedInUser.email != null
          //     ?
          ,
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email:',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${user!.email}",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.7),
                  ),
                )
              ],
            ),
          )
          // : SizedBox.shrink(),
          // loggedInUser.phoneNumber != null
          //     ? Padding(
          //         padding:
          //             const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             loggedInUser.phoneNumber != null
          //                 ? Text(
          //                     'Phone no:',
          //                     style: GoogleFonts.lato(
          //                         fontSize: 20,
          //                         color: Colors.black.withOpacity(0.7),
          //                         fontWeight: FontWeight.bold),
          //                   )
          //                 : SizedBox.shrink(),
          //             Text(
          //               "${loggedInUser.phoneNumber}",
          //               style: GoogleFonts.lato(
          //                 fontSize: 20,
          //                 color: Colors.black.withOpacity(0.7),
          //               ),
          //             )
          //           ],
          //         ),
          //       )
          //     : SizedBox.shrink(),
          ,
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language:',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'English',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Country:',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Pakistan',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.7),
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

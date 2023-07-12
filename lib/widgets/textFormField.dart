// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:travel_app/utils/color_utils.dart';

// class Textformfield extends StatelessWidget {
//   Textformfield({
//     Key? key,
//     required this.keyboard,
//     required this.hintText,
//     required this.obsecure,
//     required this.controller,
//     required this.validator,
//     required this.suffixicon,
//     this.prefixicon,
//     this.onchange,
//     this.formatterList
//   }) : super(key: key);

//   final String hintText;
//   dynamic controller;
//   dynamic keyboard;
//   final bool obsecure;
//   final FormFieldValidator<String?>? validator;
//   final IconButton? suffixicon;
//   final Icon? prefixicon;
//   final Function(String)? onchange;
//   final dynamic formatterList;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         margin: EdgeInsets.only(bottom: 8),
//         padding: EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                   blurRadius: 1,
//                   spreadRadius: 1,
//                   offset: const Offset(1, 1),
//                   color: Colors.black.withOpacity(0.1)),
//               BoxShadow(
//                   blurRadius: 1,
//                   spreadRadius: 1,
//                   offset: const Offset(-1, -1),
//                   color: Colors.black.withOpacity(0.1))
//             ]),
//         child: Center(

//           child: TextFormField(
//             keyboardType: keyboard,
//             inputFormatters: formatterList,
//             textAlign: TextAlign.justify,
//             textAlignVertical: TextAlignVertical.center,
//             textDirection: TextDirection.ltr,
//             validator: validator,
//             controller: controller,
//             obscureText: obsecure,
//             onChanged: onchange,
//             decoration: InputDecoration(
//               prefixIconColor: Colors.blue,
//               suffixIconColor: Colors.blue,
//               enabledBorder: InputBorder.none,
//               border: InputBorder.none,
//               // border: OutlineInputBorder(
//               //     borderRadius: BorderRadius.circular(10),
//               // borderSide: BorderSide(color: Colors.blue)
//               // ),
//               hintText: hintText,
//               hintStyle: GoogleFonts.lato(
//                 color: Colors.black,
//               ),
//               // label: Text(
//               //   label,
//               //   style: GoogleFonts.josefinSans(color: Colors.red),
//               // ),
//               prefixIcon: prefixicon,
//               suffixIcon: suffixicon,
//               iconColor: kPColor,

//               // fillColor: Colors.blue[50],
//               // filled: true
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:travel_app/utils/color_utils.dart';

class Textformfield extends StatelessWidget {
  Textformfield(
      {Key? key,
      required this.keyboard,
      required this.hintText,
      required this.obsecure,
      required this.controller,
      required this.validator,
      required this.suffixicon,
      required this.enableSuggestions,
      this.prefixicon,
      this.onchange,
      this.formatterList})
      : super(key: key);

  final String hintText;
  dynamic controller;
  dynamic keyboard;
  final bool obsecure;
  final bool enableSuggestions;
  final FormFieldValidator<String?>? validator;
  final IconButton? suffixicon;
  final Icon? prefixicon;
  final Function(String)? onchange;
  final dynamic formatterList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        inputFormatters: formatterList,
        onChanged: onchange,
        autofocus: false,
        obscureText: obsecure,
        enableSuggestions: true,
        autocorrect: true,
        controller: controller,
        cursorColor: Colors.black45,
        style: TextStyle(color: kPColor),
        keyboardType: keyboard,
        validator: validator,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: prefixicon,
            suffixIcon: suffixicon,
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: hintText,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: white.withOpacity(0.3),
            hintStyle: TextStyle(color: black),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.blue)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    const BorderSide(width: 0, style: BorderStyle.solid))),
      ),
    );
  }
}

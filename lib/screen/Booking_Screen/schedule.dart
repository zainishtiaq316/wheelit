// import 'package:flutter/material.dart';

// class ScheduleScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Schedule')),
//       ),
//       body: ListView(
//         children: [
//           TripCard(
//             name: "Afaq Ahmad",
//             location: 'Swat,KPK ',
//             startdate: '25 Jan,2023 ',
//             enddate: '3 Feb 2023',
//             imageUrl: AssetImage('assets/places/place11.jpg'),
//             height: 230,
//             width: 500,
//             email: "afaqahmad.7866@gmail.com",
//             Contact: "+923027890765",
//             source: "Jhelum",
//             destignation: " Swat",
//             Address: "Jhelum City ",
//           )
//         ],
//       ),
//     );
//   }
// }

// class TripCard extends StatelessWidget {
//   final String name;
//   final String location;
//   final String startdate;
//   final String enddate;
//   final String Contact;
//   final String email;
//   final String Address;
//   final AssetImage imageUrl;
//   final double width;
//   final double height;
//   final String source;
//   final String destignation;

//   TripCard(
//       {required this.name,
//       required this.location,
//       required this.startdate,
//       required this.enddate,
//       required this.imageUrl,
//       required this.width,
//       required this.height,
//       required this.Contact,
//       required this.email,
//       required this.Address,
//       required this.source,
//       required this.destignation});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: () {
//           // Navigate to trip details screen
//         },
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Schedule Trip",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text("Source Point : $source",
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               "Destination Point : $destignation",
//               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text("Trip Schedule : $startdate to $enddate",
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               "Driver Information",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text("Name : $name",
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
//             SizedBox(
//               height: 10,
//             ),
//             Text("Contact : $Contact",
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
//             SizedBox(
//               height: 10,
//             ),
//             Text("Email : $email",
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "Trip Location",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text("Location : $location",
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
//             SizedBox(
//               height: 10,
//             ),
//             Image(
//               image: imageUrl,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 elevation: 0,
//                 shape: const StadiumBorder(),
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 15,
//                   horizontal: 8.0,
//                 ),
//               ),
//               child: const Text("Delete Schedule"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

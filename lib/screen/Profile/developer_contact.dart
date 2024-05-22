// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperContactPage extends StatelessWidget {
  const DeveloperContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact With Developer'),
        backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: Zain Ishtiaq',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Email: zainishtiaq.7866@gmail.com',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Phone: +92 3335973759',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton.icon(
            onPressed: () async {
              final Uri params = Uri(
                scheme: 'mailto',
                path: 'zainishtiaq.7866@gmail.com',
                query: 'subject=Subject&body=Enter your message',
              );
              String url = params.toString();
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Could not launch email app'),
                ));
              }
            },
            icon: Icon(Icons.email),
            label: Text('Send Email'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton.icon(
            onPressed: () async {
              String phoneNumber = '+923335973759';
              String url = 'tel:$phoneNumber';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Could not launch phone app'),
                ));
              }
            },
            icon: Icon(Icons.call),
            label: Text('Make a Call'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

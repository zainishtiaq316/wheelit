import 'package:flutter/material.dart';

import 'developer_contact.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Help Center'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),

      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('How do I create an account?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                    'To create an account, go to the registration page and fill in the required details. Once you have submitted the form, you will receive a verification email. Click on the verification link in the email to activate your account.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('How do I book a tour?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                    'To book a tour, go to the tours page and select the tour you want to book. Choose the date and time. Review the tour details and click on the "Book Now" button to complete the booking process.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('How do I view my bookings?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                    'To view your bookings, go to the bookings page and log in to your account. You will see a list of all your bookings, along with their details.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Developer Contacts',
              style: TextStyle(color: Colors.black),
            ),
            children: [
              ListTile(
                title: Text(
                  'Contact with Developer',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeveloperContactPage(),
                    ),
                  );
                },
              ),
            ],
          )

          // Add more queries and their answers as needed
        ],
      ),
    );
  }
}

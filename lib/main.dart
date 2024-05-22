import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screen/Signin_Signup_Forgot_Screen/splash.dart';
import 'package:travel_app/utils/color_utils.dart';
import 'package:travel_app/widgets/notificationService.dart';
import 'firebase_options.dart';

// Future<bool> checkInternetConnectivity() async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     NotificationService.initialize();
//     FirebaseMessaging.onBackgroundMessage(
//         NotificationService.firebaseMessagingBackgroundHandler);

//     // NotificationService.terminatedStateHandling();

//     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//   } catch (e) {
//     return false;
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  NotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(
      await NotificationService.firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
  // await checkInternetConnectivity();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wheel it',
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: kPColor,
      ),
      home: Splash(),
      // home: AdminBottomNav(),
    );
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final _firebaseMessaging = FirebaseMessaging.instance;
  
    static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      // android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      android: AndroidInitializationSettings("@drawable/logo"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: (details) {
      //   FirebaseDatabase.instance.ref("Notifications").push().set({
      //     "title": ,
      //     "message":
      //   });
      // },
    );
  }

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true,
      showBadge: true);

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // await Firebase.initializeApp();
    // await _firebaseMessaging.subscribeToTopic("skillspot");

    NotificationService.flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            NotificationService.channel.id,
            NotificationService.channel.name,
            NotificationService.channel.description,
          ),
        ));
    print(
        "A bg message just showed up : ${message.notification!.title}\n ${message.notification!.body}");
  }

  static Future<void> setForegroundNotificationPresentationOptions() async {
    // await _firebaseMessaging.subscribeToTopic("skillspot");
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // static Future<void> terminatedStateHandling() async {
  //   RemoteMessage? initialMessage =
  //       await _firebaseMessaging.getInitialMessage();
  //   if (initialMessage != null) {
  //     print(initialMessage);
  //     PushNotification(
  //       title: initialMessage.notification!.title.toString(),
  //       body: initialMessage.notification!.body.toString(),
  //       dataTitle: initialMessage.data['title'],
  //       dataBody: initialMessage.data['body'],
  //     );
  //   }
  // }


  // Function for notification in Running State
  // static Future<void> registerNotification() async {
  //   await Firebase.initializeApp();

  //   NotificationSettings settings = await _firebaseMessaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //     provisional: false,
  //   );
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       PushNotification(
  //         title: message.notification!.title.toString(),
  //         body: message.notification!.body.toString(),
  //         dataTitle: message.data['sender'],
  //         dataBody: message.data['text'],
  //       );
  //     });
  //   } else {
  //     print("Permission declined by user");
  //   }
  // }

//   static void createanddisplaynotification(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//             'high_importance_channel', // id
//             'High Importance Notifications', // title
//             'This channel is used for important notifications.', // description
//             importance: Importance.max,
//             priority: Priority.high,
//             color: kPColor,
//             playSound: true,
//             icon: '@drawable/logo'
//             // icon: 'logo'
//             ),
//       );

//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data['_id'],
//       );

//       // final pushkey = FirebaseDatabase.instance.ref().push().key!;
//       // await FirebaseDatabase.instance.ref("Notifications").child(pushkey).set({
//       //   "id": pushkey,
//       //   "title": message.notification!.title,
//       //   "message": message.notification!.body,
//       //   "timestamp": DateTime.now().millisecondsSinceEpoch,
//       // });
//     } on Exception catch (e) {
//       print(e);
//     }
//   }
// }

}

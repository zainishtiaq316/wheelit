import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

Future<void> sendPushNotification(
    String token, String title, String message) async {
  try {
    var res = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'key=AAAAVEFeIOc:APA91bHcGLAi89NIOg8JMrLi04-qI9pCUvH7MLFieK9jInBlEmHMnD3lYFPsY1hRv-Z7whnWYsHFmAn7jhCOAa4CrDSEKkM3TqheoQF0TFUbTwdTruygjm5SpuFtbVmVDF8Dt_e5-E1d'
        },
        body:
            constructFCMPayload(token: token, title: title, message: message));
    print('Response status: ${res.statusCode}');
    print('Response body: ${res.body}');
  } catch (e) {
    print('\nsendPushNotificationE: $e');
  }
}

String constructFCMPayload({
  required String? token,
  required String title,
  required String message,
  // required String counselorImage
}) {
  return jsonEncode({
    'to': token,
    'data': {
      'title': title,
      'body': message,
      // 'icon': counselorImage,
    },
    'notification': {
      'title': title,
      'body': message,
      // 'icon': counselorImage,
    }
  });
}

Future<void> addNotifications(
    String userid, String id, String title, String message) async {
  await FirebaseFirestore.instance
      .collection("Notifications")
      .doc(userid)
      .collection("Notifications")
      .doc(id)
      .set({
    'id': id,
    'title': title,
    'message': message,
  });
}

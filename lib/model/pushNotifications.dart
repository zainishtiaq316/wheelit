class PushNotification {
  PushNotification({
    required this.title,
    required this.body,
    required this.dataTitle,
    required this.dataBody,
  });

  String title;
  String body;
  String dataTitle;
  String dataBody;
}

class NotificatoinDataClass {
  String id;
  String title;
  String message;
  int timestamp;
  NotificatoinDataClass({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
  });

  factory NotificatoinDataClass.fromJson(dynamic json) {
    return NotificatoinDataClass(
        id: json["id"] ?? "", title: json["title"] ?? "", message: json["message"] ?? "", timestamp: json["timestamp"] ?? "");
  }
}
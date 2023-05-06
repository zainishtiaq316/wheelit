import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  String id;
  String title;
  String message;
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
  });
  // int timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      title: map['title'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

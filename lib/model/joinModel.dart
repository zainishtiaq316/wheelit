import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JoinModel {
  final String id;
  final String name;
  final String contact;
  final String email;
  final String source;
  final String destination;
  final String startDate;
  final String endDate;
  final String userId;
  final String userToken;
  final String userImage;
  JoinModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.email,
    required this.source,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.userToken,
    required this.userImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
      'source': source,
      'destination': destination,
      'startDate': startDate,
      'endDate': endDate,
      'userId': userId,
      'userToken': userToken,
      'userImage': userImage,
    };
  }

  factory JoinModel.fromMap(Map<String, dynamic> map) {
    return JoinModel(
      id: map['id'] as String,
      name: map['name'] as String,
      contact: map['contact'] as String,
      email: map['email'] as String,
      source: map['source'] as String,
      destination: map['destination'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      userId: map['userId'] as String,
      userToken: map['userToken'] as String,
      userImage: map['userImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JoinModel.fromJson(String source) => JoinModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

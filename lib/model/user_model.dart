class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phoneNumber;
  String? photoURL;
  String? token;
  String? role;
  // NotificationModel? notifications;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.phoneNumber,
    this.photoURL,
    this.role,
    this.token,
    // this.notifications.
  });

  // recieving data from serve
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'] ,
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      phoneNumber: map['phoneNumber'],
      photoURL: map['photoURL'],
      role: map['role'] ?? "User",
      token: map['token'] ?? "",
      // notifications: map['notifications'] ?? List<NotificationModel>
    );
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'token': token,
      'role': role,
      // 'notifications':notifications
    };
  }
}

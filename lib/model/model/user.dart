import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String name;
  //final String PhoneNumber;
  final List History;

  const User({
    required this.uid,
    required this.email,
    // required this.PhoneNumber,
    required this.History,
    required this.name,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
      name: snapshot["name"],
      //  PhoneNumber: snapshot["PhoneNumber"],
      History: snapshot["History"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        //  "PhoneNumber": PhoneNumber,
        "History": History,
        "name": name,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String enrollmentNo;
  final String username;
  final String email;
  final String photoUrl;
  final String bio;
  final List friends;
  // final List followers;
  // final List following;

  User({
    required this.id,
    required this.enrollmentNo,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.bio,
    required this.friends,
    // required this.followers,
    // required this.following,
    // required this.name,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      id: snapshot["id"],
      enrollmentNo: snapshot["enrollmentNo"],
      username: snapshot["username"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      friends: snapshot["friends"],
      // followers: snapshot["followers"],
      // following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "enrollmentNo": enrollmentNo,
        "username": username,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "friends" : friends,
        // "followers": followers,
        // "following": following,
      };
}

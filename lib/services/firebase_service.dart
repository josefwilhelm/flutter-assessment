import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assessment/logger.dart';
import 'package:flutter_assessment/models/user.dart';

enum AuthProblems { UserNotFound, PasswordNotValid, NetworkError }

class FirebaseService {
  var _fireStoreInstance = Firestore.instance;
  final logger = getLogger("FirebaseService");

  saveUser(User user) async {
    _fireStoreInstance
        .collection("users")
        .document(user.id)
        .setData(user.toJson());
  }

  Future<User> getUser(FirebaseUser user) async {
    final doc =
        await _fireStoreInstance.collection("users").document(user.uid).get();
    return User.fromJson(doc.data);
  }
}

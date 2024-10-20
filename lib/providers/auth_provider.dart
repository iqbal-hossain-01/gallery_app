import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gallery_app/services/firebase_service.dart';

class FirebaseAuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  Future<bool> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return FirebaseService.isAdmin(credential.user!.uid);
  }

  Future<void> logout() => _auth.signOut();
}
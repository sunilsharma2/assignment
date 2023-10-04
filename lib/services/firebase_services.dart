
import 'package:assignment/models/signed_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future<String?>signUp({String? email, String? password}) async {
    try {
      UserCredential userCredential= await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      User? user = userCredential.user;
      return user?.uid;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  //SIGN IN METHOD
  Future<String?> signIn({String? email, String? password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      User? user = userCredential.user;
      return user?.uid;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }

  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
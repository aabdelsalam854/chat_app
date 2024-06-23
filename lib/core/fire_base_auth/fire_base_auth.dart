import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  final FirebaseAuth firebaseAuth;
  FireAuth(this.firebaseAuth);
  Future<UserCredential> createUserWithEmailAndPassword(
      final String emailAddress, final String password) async {
    var credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    return credential;
  }

  Future<UserCredential> loginWithEmailAndPassword(
      final String emailAddress, final String password) async {
    var credential = await firebaseAuth.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    log(credential.toString());
    return credential;
  }
}

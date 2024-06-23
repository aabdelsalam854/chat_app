import 'package:firebase_auth/firebase_auth.dart';

abstract class Fuiler {
  final String message;

  const Fuiler(this.message);
}

class FirebaseError extends Fuiler {
  FirebaseError(super.message);

  factory FirebaseError.fromFirebaseAuthException(FirebaseAuthException e) {
    String errorMessage = 'An error occurred';
    if (e.code == 'user-not-found') {
      errorMessage = 'User not found';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'Email already in use';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'Invalid email';
    }
    return FirebaseError(errorMessage);
  }
}

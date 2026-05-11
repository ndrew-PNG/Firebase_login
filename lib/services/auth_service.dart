import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// AuthService - handles Firebase authentication
class AuthService {
  // Get instance of Firebase Authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Get current logged-in user
  User? get currentUser => _firebaseAuth.currentUser;

  // Stream to listen for authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign up with email and password
  Future<void> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Handle Firebase auth errors
  String _handleAuthException(FirebaseAuthException e) {
    if (kDebugMode) {
      print('Firebase Error Code: ${e.code}');
      print('Firebase Error Message: ${e.message}');
    }
    
    switch (e.code) {
      case 'user-not-found':
        return 'Email not found. Please register first.';
      case 'wrong-password':
        return 'Wrong password. Please try again.';
      case 'email-already-in-use':
        return 'Email already in use. Please sign in instead.';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        if (kDebugMode) {
          print('Unhandled Firebase Error: ${e.code} - ${e.message}');
        }
        return 'Authentication error: ${e.message}';
    }
  }
}

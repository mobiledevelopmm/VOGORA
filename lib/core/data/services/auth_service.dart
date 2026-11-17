
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthService({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  // Register
  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential =
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw Exception('User account could not be created.');
    }

    // Save display name in Firebase Authentication
    await user.updateDisplayName(name.trim());
    await user.reload();

    final updatedUser = _firebaseAuth.currentUser ?? user;

    // Save user profile in Firestore
    await _firestore.collection('users').doc(updatedUser.uid).set({
      'uid': updatedUser.uid,
      'name': name.trim(),
      'email': updatedUser.email,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return credential;
  }

  // Login
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw Exception('Unable to retrieve user information.');
    }

    // Save or update user profile in Firestore
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': user.displayName ?? '',
      'email': user.email,
      'lastLoginAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return credential;
  }

  // Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // Current User
  User? get currentUser => _firebaseAuth.currentUser;

  // Authentication State
  Stream<User?> get authStateChanges =>
      _firebaseAuth.authStateChanges();
}

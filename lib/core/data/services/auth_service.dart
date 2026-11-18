
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

    await user.updateDisplayName(name.trim());
    await user.reload();

    final updatedUser = _firebaseAuth.currentUser ?? user;

    await _firestore.collection('users').doc(updatedUser.uid).set({
      'uid': updatedUser.uid,
      'name': name.trim(),
      'email': updatedUser.email,
      'gender': null,
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
    final credential =
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw Exception('Unable to retrieve user information.');
    }

    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': user.displayName ?? '',
      'email': user.email,
      'lastLoginAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return credential;
  }

  // Check whether gender has been selected
  Future<bool> hasSelectedGender(String uid) async {
    final document =
    await _firestore.collection('users').doc(uid).get();

    final gender = document.data()?['gender'];

    return gender == 'Male' || gender == 'Female';
  }

  Future<String?> getUserGender(String uid) async {
    final document =
    await _firestore.collection('users').doc(uid).get();

    final gender = document.data()?['gender'];

    if (gender == 'Male' || gender == 'Female') {
      return gender as String;
    }

    return null;
  }



  Future<void> saveGender(String gender) async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    await _firestore.collection('users').doc(user.uid).set({
      'gender': gender,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }


  Future<int?> getUserAge(String uid) async {
    final document =
    await _firestore.collection('users').doc(uid).get();

    final age = document.data()?['age'];

    if (age is int) return age;
    if (age is String) return int.tryParse(age);

    return null;
  }

  Future<void> updatePersonalInfo({
    required String name,
    required String gender,
    int? age,
  }) async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final updatedName = name.trim();

    if (updatedName.isEmpty) {
      throw Exception('Name cannot be empty.');
    }

    if (gender != 'Male' && gender != 'Female') {
      throw Exception('Please select a valid gender.');
    }

    if (age != null && (age < 1 || age > 120)) {
      throw Exception('Please enter a valid age.');
    }

    await user.updateDisplayName(updatedName);
    await user.reload();

    final updatedUser = _firebaseAuth.currentUser;

    if (updatedUser == null) {
      throw Exception('Unable to update user information.');
    }

    final data = <String, dynamic>{
      'name': updatedName,
      'gender': gender,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (age == null) {
      data['age'] = FieldValue.delete();
    } else {
      data['age'] = age;
    }

    await _firestore.collection('users').doc(updatedUser.uid).set(
      data,
      SetOptions(merge: true),
    );
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

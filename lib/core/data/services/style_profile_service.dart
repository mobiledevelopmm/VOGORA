
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StyleProfileService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  StyleProfileService({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>> get _userDocument {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return _firestore.collection('users').doc(user.uid);
  }

  // Save selected undertone
  Future<void> saveUndertone(String undertone) async {
    if (!['Cool', 'Warm', 'Neutral'].contains(undertone)) {
      throw Exception('Invalid undertone selection.');
    }

    await _userDocument.set({
      'undertone': undertone,
      'styleProfileUpdatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Save body measurements and calculated body shape
  Future<void> saveBodyMeasurements({
    required double height,
    required double weight,
    required double shoulder,
    required double bust,
    required double waist,
    required double hip,
    required String unit,
    required String bodyShape,
  }) async {
    if (!['cm', 'in'].contains(unit)) {
      throw Exception('Invalid measurement unit.');
    }

    await _userDocument.set({
      'bodyMeasurements': {
        'height': height,
        'weight': weight,
        'shoulder': shoulder,
        'bust': bust,
        'waist': waist,
        'hip': hip,
        'unit': unit,
      },
      'bodyShape': bodyShape,
      'styleProfileUpdatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Retrieve saved style profile
  Future<Map<String, dynamic>?> getStyleProfile() async {
    final snapshot = await _userDocument.get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return {
      'undertone': data['undertone'],
      'bodyMeasurements': data['bodyMeasurements'],
      'bodyShape': data['bodyShape'],
    };
  }
}
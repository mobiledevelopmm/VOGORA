import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/outfit_item_model.dart';

class OutfitService {
  final FirebaseFirestore _firestore;

  OutfitService(this._firestore);

  Stream<List<OutfitItem>> getOutfits({
    required String gender,
    required String type,
  }) {
    debugPrint('========== OUTFIT DEBUG ==========');
    debugPrint('Requested gender: $gender');
    debugPrint('Requested type: $type');

    return _firestore
        .collection('casual_01')
        .snapshots().map((snapshot) {
      debugPrint('Total Firestore documents: ${snapshot.docs.length}');

      final outfits = snapshot.docs.map((doc) {
        final data = doc.data();

        debugPrint('Document ID: ${doc.id}');
        debugPrint('Data: $data');

        return OutfitItem.fromFirestore(doc.id, data);
      }).toList();

      final filtered = outfits.where((outfit) {
        final matchesGender =
            outfit.gender.trim().toLowerCase() ==
                gender.trim().toLowerCase();

        final matchesType =
            outfit.type.trim().toLowerCase() ==
                type.trim().toLowerCase();

        final active = outfit.isActive;

        debugPrint(
          '${outfit.id}: gender=$matchesGender, '
              'type=$matchesType, active=$active, '
              'imageUrl=${outfit.imageURL}',
        );

        return matchesGender && matchesType && active;
      }).toList();

      debugPrint('Filtered outfits: ${filtered.length}');
      debugPrint('==================================');

      return filtered;
    });
  }
}
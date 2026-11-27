
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/outfit_item_model.dart';

class OutfitService {
  final FirebaseFirestore _firestore;

  OutfitService(this._firestore);

  static const List<String> _categories = [
    'casual',
    'formal',
    'korean',
    'sporty',
    'streetwear',
  ];

  Stream<List<OutfitItem>> getOutfits({
    required String gender,
    required String type,
  }) {
    final normalizedGender =
    gender.trim().toLowerCase() == 'male'
        ? 'Male'
        : 'Female';

    final streams = _categories.map((category) {
      return _firestore
          .collection('outfits')
          .doc(category)
          .collection(normalizedGender)
          .snapshots();
    }).toList();

    return CombineLatestStream.list(streams).map((snapshots) {
      final outfits = <OutfitItem>[];

      for (int i = 0; i < snapshots.length; i++) {
        final snapshot = snapshots[i];
        final category = _categories[i];

        debugPrint(
          'CATEGORY: $category | '
              'GENDER: $normalizedGender | '
              'DOCUMENTS: ${snapshot.docs.length}',
        );

        for (final doc in snapshot.docs) {
          final outfit = OutfitItem.fromFirestore(
            doc.id,
            doc.data(),
          );

          final isTypeMatched =
              outfit.type.trim().toLowerCase() ==
                  type.trim().toLowerCase();

          final hasImage = outfit.imageURL.trim().isNotEmpty;

          debugPrint(
            'ID: ${doc.id} | '
                'Category: ${outfit.category} | '
                'Type: ${outfit.type} | '
                'Active: ${outfit.isActive} | '
                'Image: $hasImage | '
                'TypeMatched: $isTypeMatched',
          );

          if (outfit.isActive &&
              isTypeMatched &&
              hasImage) {
            outfits.add(outfit);
          }
        }
      }

      debugPrint(
        'TOTAL OUTFITS: ${outfits.length} | '
            'GENDER: $normalizedGender | TYPE: $type',
      );

      return outfits;
    });
  }
}
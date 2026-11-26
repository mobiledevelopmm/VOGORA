
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
    gender.trim().toLowerCase() == 'male' ? 'Male' : 'Female';

    final streams = _categories.map((category) {
      return _firestore
          .collection('outfits')
          .doc(category)
          .collection(normalizedGender)
          .snapshots();
    }).toList();

    return CombineLatestStream.list(streams).map((snapshots) {
      final outfits = <OutfitItem>[];

      for (final snapshot in snapshots) {
        for (final doc in snapshot.docs) {
          final outfit = OutfitItem.fromFirestore(
            doc.id,
            doc.data(),
          );
          debugPrint(
            'ID: ${outfit.id}, '
                'Category: ${outfit.category}, '
                'Type: ${outfit.type}, '
                'Active: ${outfit.isActive}, '
                'Image: ${outfit.imageURL.isNotEmpty}',
          );

          if (outfit.isActive &&
              outfit.type.trim().toLowerCase() ==
                  type.trim().toLowerCase() &&
              outfit.imageURL.isNotEmpty) {
            outfits.add(outfit);
          }
        }
      }

      debugPrint('Total outfits: ${outfits.length}');
      return outfits;
    });
  }
}

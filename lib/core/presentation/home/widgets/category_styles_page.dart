
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/models/outfit_item_model.dart';
import '../../../data/datasources/services/outfit_service.dart';
import '../../auth/widgets/fashion_background.dart';
import 'outfit_detail_page.dart';
import 'outfit_grid_card.dart';

class CategoryStylesPage extends StatefulWidget {
  final String category;
  final String gender;

  const CategoryStylesPage({
    super.key,
    required this.category,
    required this.gender,
  });

  @override
  State<CategoryStylesPage> createState() => _CategoryStylesPageState();
}

class _CategoryStylesPageState extends State<CategoryStylesPage> {
  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);

  late final OutfitService _outfitService;

  @override
  void initState() {
    super.initState();
    _outfitService = OutfitService(FirebaseFirestore.instance);
  }

  void _openOutfitDetail(OutfitItem outfit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OutfitDetailPage(
          outfit: outfit,
          categoryName: outfit.category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FashionBackground(
      overlayOpacity: 0.88,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 20, 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: berry,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.category,
                        style: const TextStyle(
                          color: espresso,
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<List<OutfitItem>>(
                  stream: _outfitService.getOutfits(
                    gender: widget.gender,
                    type: 'styled_for_you',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: berry),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Unable to load outfits.'),
                      );
                    }

                    final outfits = (snapshot.data ?? [])
                        .where(
                          (outfit) =>
                      outfit.category.toLowerCase() ==
                          widget.category.toLowerCase(),
                    )
                        .toList();

                    if (outfits.isEmpty) {
                      return const Center(
                        child: Text(
                          'No outfits found in this category.',
                          style: TextStyle(color: espresso),
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
                      itemCount: outfits.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final outfit = outfits[index];

                        return GestureDetector(
                          onTap: () => _openOutfitDetail(outfit),
                          child: OutfitGridCard(item: outfit),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../auth/widgets/fashion_background.dart';
import '../models/outfit_item.dart';
import 'outfit_grid_card.dart';

class CategoryStylesPage extends StatelessWidget {
  final String categoryName;
  final List<OutfitItem> outfits;

  const CategoryStylesPage({
    super.key,
    required this.categoryName,
    required this.outfits,
  });

  static const Color coral = Color(0xFFFF5E62);
  static const Color espresso = Color(0xFF29211F);

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
                padding: const EdgeInsets.fromLTRB(16, 12, 20, 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: espresso,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        categoryName,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: espresso,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Explore $categoryName outfits and get inspired.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: espresso,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: outfits.isEmpty
                    ? const Center(
                  child: Text('No outfits available yet.'),
                )
                    : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    0,
                    20,
                    24,
                  ),
                  itemCount: outfits.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    return OutfitGridCard(
                      item: outfits[index],
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

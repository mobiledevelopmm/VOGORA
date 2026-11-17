
import 'package:flutter/material.dart';

import '../../auth/widgets/fashion_background.dart';
import '../models/outfit_item.dart';
import '../widgets/category_styles_page.dart';
import '../widgets/outfit_grid_card.dart';

class TrendingStylesPage extends StatefulWidget {
  final String? initialCategory;

  const TrendingStylesPage({
    super.key,
    this.initialCategory,
  });

  @override
  State<TrendingStylesPage> createState() =>
      _TrendingStylesPageState();
}

class _TrendingStylesPageState extends State<TrendingStylesPage> {
  static const Color coral = Color(0xFFFF5E62);
  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);

  final List<String> categories = [
    'Old Money',
    'Coquette',
    'Y2K',
    'Minimalist',
    'Quiet Luxury',
  ];

  late String selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.initialCategory != null &&
        categories.contains(widget.initialCategory)
        ? widget.initialCategory!
        : 'Old Money';
  }

  final Map<String, List<OutfitItem>> outfitsByCategory = {
    'Old Money': [
      OutfitItem(
        title: 'Classic Elegance',
        description: 'Elegant blazer with tailored trousers',
        imageUrl:
        'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=600',
      ),
      OutfitItem(
        title: 'Quiet Sophistication',
        description: 'Timeless neutral fashion look',
        imageUrl:
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=600',
      ),
      OutfitItem(
        title: 'Luxury Casual',
        description: 'Polished and effortless everyday style',
        imageUrl:
        'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=600',
      ),
    ],
    'Coquette': [
      OutfitItem(
        title: 'Soft Romantic',
        description: 'Feminine and delicate outfit',
        imageUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600',
      ),
      OutfitItem(
        title: 'Sweet Elegance',
        description: 'Soft and graceful fashion look',
        imageUrl:
        'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=600',
      ),
      OutfitItem(
        title: 'Romantic Style',
        description: 'Charming and feminine aesthetic',
        imageUrl:
        'https://images.unsplash.com/photo-1485230895905-ec40ba36b9bc?w=600',
      ),
    ],
    'Y2K': [
      OutfitItem(
        title: 'Y2K Street Look',
        description: 'Bold and playful early 2000s style',
        imageUrl:
        'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?w=600',
      ),
      OutfitItem(
        title: 'Retro Vibes',
        description: 'Trendy vintage-inspired outfit',
        imageUrl:
        'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=600',
      ),
      OutfitItem(
        title: 'Modern Y2K',
        description: 'Fun and expressive fashion',
        imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600',
      ),
    ],
    'Minimalist': [
      OutfitItem(
        title: 'Clean Minimal',
        description: 'Simple and clean everyday outfit',
        imageUrl:
        'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=600',
      ),
      OutfitItem(
        title: 'Neutral Outfit',
        description: 'Minimal neutral color combination',
        imageUrl:
        'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=600',
      ),
      OutfitItem(
        title: 'Simple Chic',
        description: 'Effortless and modern fashion',
        imageUrl:
        'https://images.unsplash.com/photo-1544441893-675973e31985?w=600',
      ),
    ],
    'Quiet Luxury': [
      OutfitItem(
        title: 'Timeless Luxury',
        description: 'Refined and understated elegance',
        imageUrl:
        'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=600',
      ),
      OutfitItem(
        title: 'Elegant Neutral',
        description: 'Sophisticated neutral outfit',
        imageUrl:
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=600',
      ),
      OutfitItem(
        title: 'Modern Classic',
        description: 'Premium and timeless appearance',
        imageUrl:
        'https://images.unsplash.com/photo-1509631179647-0177331693ae?w=600',
      ),
    ],
  };

  // Open the selected category page.
  void _openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryStylesPage(
          categoryName: category,
          outfits: outfitsByCategory[category] ?? [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentOutfits = outfitsByCategory[selectedCategory] ?? [];

    return FashionBackground(
      overlayOpacity: 0.88,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 20, 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: berry,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Expanded(
                      child: Text(
                        'Trending Styles',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: espresso,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Explore popular fashion styles and get inspired.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6F625D),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Category Buttons
              SizedBox(
                height: 43,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 9),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;

                    return ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      showCheckmark: false,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      backgroundColor:
                      Colors.white.withValues(alpha: 0.8),
                      selectedColor: berry,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : espresso,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? berry
                            : berry.withValues(alpha: 0.15),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Selected Category
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      selectedCategory,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: espresso,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: coral.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${currentOutfits.length} Looks',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: berry,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Outfit Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                  itemCount: currentOutfits.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.66,
                  ),
                  itemBuilder: (context, index) {
                    final outfit = currentOutfits[index];

                    return GestureDetector(
                      onTap: () {
                        _openCategory(selectedCategory);
                      },
                      child: OutfitGridCard(item: outfit),
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

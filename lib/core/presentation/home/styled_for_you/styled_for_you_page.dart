
import 'package:flutter/material.dart';

import '../../auth/widgets/fashion_background.dart';
import '../models/outfit_item.dart';
import '../widgets/category_styles_page.dart';
import '../widgets/outfit_grid_card.dart';

class StyledForYouPage extends StatefulWidget {
  final String? initialCategory;

  const StyledForYouPage({
    super.key,
    this.initialCategory,
  });

  @override
  State<StyledForYouPage> createState() =>
      _StyledForYouPageState();
}

class _StyledForYouPageState extends State<StyledForYouPage> {
  static const Color coral = Color(0xFFFF5E62);
  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);

  final List<String> categories = [
    'Casual',
    'Korean',
    'Streetwear',
    'Formal',
    'Sporty',
  ];
  late String selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.initialCategory != null &&
        categories.contains(widget.initialCategory)
        ? widget.initialCategory!
        : 'Casual';
  }

  final Map<String, List<OutfitItem>> outfitsByCategory = {
    'Casual': [
      OutfitItem(
        title: 'Casual Chic',
        description: 'Simple and comfortable everyday outfit',
        imageUrl:
        'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=700',
      ),
      OutfitItem(
        title: 'Relaxed Look',
        description: 'A relaxed and effortless combination',
        imageUrl:
        'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=700',
      ),
      OutfitItem(
        title: 'Everyday Fashion',
        description: 'Easy pieces for daily wear',
        imageUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=700',
      ),
    ],
    'Korean': [
      OutfitItem(
        title: 'Korean Minimal',
        description: 'Clean and minimal Korean fashion',
        imageUrl:
        'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=700',
      ),
      OutfitItem(
        title: 'Soft Korean Look',
        description: 'Soft colors and elegant silhouettes',
        imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=700',
      ),
      OutfitItem(
        title: 'Modern Korean',
        description: 'Modern everyday Korean outfit',
        imageUrl:
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=700',
      ),
    ],
    'Streetwear': [
      OutfitItem(
        title: 'Urban Street',
        description: 'Bold street-inspired outfit',
        imageUrl:
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=700',
      ),
      OutfitItem(
        title: 'Street Chic',
        description: 'Comfortable and confident street style',
        imageUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=700',
      ),
      OutfitItem(
        title: 'Modern Street',
        description: 'Modern urban fashion inspiration',
        imageUrl:
        'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=700',
      ),
    ],
    'Formal': [
      OutfitItem(
        title: 'Elegant Formal',
        description: 'A polished and elegant appearance',
        imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=700',
      ),
      OutfitItem(
        title: 'Office Chic',
        description: 'Smart and sophisticated outfit',
        imageUrl:
        'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=700',
      ),
      OutfitItem(
        title: 'Classic Elegance',
        description: 'Timeless formal fashion',
        imageUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=700',
      ),
    ],
    'Sporty': [
      OutfitItem(
        title: 'Sporty Casual',
        description: 'Comfortable activewear inspiration',
        imageUrl:
        'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=700',
      ),
      OutfitItem(
        title: 'Active Look',
        description: 'Easy and energetic sporty style',
        imageUrl:
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=700',
      ),
      OutfitItem(
        title: 'Athleisure',
        description: 'Sporty pieces for everyday wear',
        imageUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=700',
      ),
    ],
  };

  // Open selected category page
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
    final currentOutfits =
        outfitsByCategory[selectedCategory] ?? [];

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
                padding: const EdgeInsets.fromLTRB(
                  12,
                  8,
                  20,
                  16,
                ),
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
                        'Styled for You',
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
                  'Discover outfits that match your personal style.',
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 9),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected =
                        selectedCategory == category;

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
                        color: isSelected
                            ? Colors.white
                            : espresso,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
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
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    0,
                    20,
                    25,
                  ),
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
                      child: OutfitGridCard(
                        item: outfit,
                      ),
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

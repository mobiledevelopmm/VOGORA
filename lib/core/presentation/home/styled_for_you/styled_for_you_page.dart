
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/models/outfit_item_model.dart';
import '../../../data/datasources/services/outfit_service.dart';
import '../../auth/widgets/fashion_background.dart';
import '../widgets/outfit_detail_page.dart';
import '../widgets/outfit_grid_card.dart';

class StyledForYouPage extends StatefulWidget {
  final String gender;
  final String? initialCategory;

  const StyledForYouPage({
    super.key,
    required this.gender,
    this.initialCategory,
  });

  @override
  State<StyledForYouPage> createState() => _StyledForYouPageState();
}

class _StyledForYouPageState extends State<StyledForYouPage> {
  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);

  final List<String> categories = [
    'All',
    'Casual',
    'Korean',
    'Streetwear',
    'Formal',
    'Minimal',
    'Vintage',
  ];

  late String selectedCategory;
  late final OutfitService _outfitService;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory ?? 'All';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 6),
                child: Text(
                  'Styled For You',
                  style: TextStyle(
                    color: espresso,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Discover outfits that match your style.',
                  style: TextStyle(
                    color: Color(0xFF796B65),
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 9),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? berry : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isSelected
                                ? berry
                                : const Color(0xFFE8DAD5),
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : espresso,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: StreamBuilder<List<OutfitItem>>(
                  stream: _outfitService.getOutfits(
                    gender: widget.gender,
                    type: 'styled_for_you',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: berry),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong. Please try again.'),
                      );
                    }

                    final outfits = snapshot.data ?? [];

                    final filteredOutfits = selectedCategory == 'All'
                        ? outfits
                        : outfits.where((outfit) {
                      return outfit.category.toLowerCase() ==
                          selectedCategory.toLowerCase();
                    }).toList();

                    if (filteredOutfits.isEmpty) {
                      return const Center(
                        child: Text(
                          'No outfits available yet.',
                          style: TextStyle(
                            color: espresso,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                      itemCount: filteredOutfits.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final outfit = filteredOutfits[index];

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
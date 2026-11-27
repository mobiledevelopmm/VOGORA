import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/datasources/services/outfit_service.dart';
import '../../../data/models/outfit_item_model.dart';
import '../auth/widgets/fashion_background.dart';
import '../home/widgets/outfit_detail_page.dart';
import '../home/widgets/outfit_grid_card.dart';
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
  static const Color secondaryText = Color(0xFF796B65);

  final List<String> categories = [
    'All',
    'Casual',
    'Korean',
    'Streetwear',
    'Formal',
    'Sporty'
  ];

  late String selectedCategory;
  late final OutfitService _outfitService;

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.initialCategory ?? 'All';

    _outfitService = OutfitService(FirebaseFirestore.instance);
  }

  void _goBack() {
    Navigator.of(context).maybePop();
  }

  void _openOutfitDetail(OutfitItem outfit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            OutfitDetailPage(outfit: outfit, categoryName: outfit.category),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 6),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE8DAD5)),
            ),
            child: IconButton(
              onPressed: _goBack,
              tooltip: 'Back',
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: espresso,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Text(
              'Styled For You',
              style: TextStyle(
                color: espresso,
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Discover outfits that match your style.',
        style: TextStyle(
          color: secondaryText,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 9),
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
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? berry : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected ? berry : const Color(0xFFE8DAD5),
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
    );
  }

  Widget _buildOutfitContent() {
    return StreamBuilder<List<OutfitItem>>(
      stream: _outfitService.getOutfits(
        gender: widget.gender,
        type: 'styled_for_you',
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: berry));
        }

        if (snapshot.hasError) {
          debugPrint('Styled For You Error: ${snapshot.error}');

          return const Center(
            child: Text(
              'Something went wrong. Please try again.',
              style: TextStyle(color: espresso),
            ),
          );
        }

        final outfits = snapshot.data ?? [];

        final filteredOutfits = selectedCategory == 'All'
            ? outfits
            : outfits.where((outfit) {
                return outfit.category.trim().toLowerCase() ==
                    selectedCategory.trim().toLowerCase();
              }).toList();

        if (filteredOutfits.isEmpty) {
          return const Center(
            child: Text(
              'No outfits available yet.',
              style: TextStyle(color: espresso, fontWeight: FontWeight.w600),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
          itemCount: filteredOutfits.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              _buildHeader(),
              _buildSubtitle(),
              const SizedBox(height: 20),
              _buildCategoryFilter(),
              const SizedBox(height: 18),
              Expanded(child: _buildOutfitContent()),
            ],
          ),
        ),
      ),
    );
  }
}

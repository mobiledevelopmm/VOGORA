
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/datasources/services/outfit_service.dart';
import '../../../data/models/outfit_item_model.dart';
import '../auth/widgets/fashion_background.dart';
import '../home/widgets/outfit_detail_page.dart';
import '../home/widgets/outfit_grid_card.dart';

class TrendingStylesPage extends StatefulWidget {
  final String gender;

  const TrendingStylesPage({
    super.key,
    required this.gender,
  });

  @override
  State<TrendingStylesPage> createState() => _TrendingStylesPageState();
}

class _TrendingStylesPageState extends State<TrendingStylesPage> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 22, 20, 6),
                child: Text(
                  'Trending Styles',
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
                  'Explore popular looks and fresh inspiration.',
                  style: TextStyle(
                    color: Color(0xFF796B65),
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: StreamBuilder<List<OutfitItem>>(
                  stream: _outfitService.getOutfits(
                    gender: widget.gender,
                    type: 'trending',
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
                        child: Text('Unable to load trending styles.'),
                      );
                    }

                    final outfits = snapshot.data ?? [];

                    if (outfits.isEmpty) {
                      return const Center(
                        child: Text(
                          'No trending styles available yet.',
                          style: TextStyle(
                            color: espresso,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
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
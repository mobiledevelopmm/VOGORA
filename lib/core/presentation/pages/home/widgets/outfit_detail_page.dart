
import 'package:flutter/material.dart';
import '../../../../data/models/outfit_item_model.dart';
import '../../auth/widgets/fashion_background.dart';

class OutfitDetailPage extends StatelessWidget {
  final OutfitItem outfit;
  final String categoryName;

  const OutfitDetailPage({
    super.key,
    required this.outfit,
    required this.categoryName,
  });

  static const Color berry = Color(0xFF91475B);
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
                    const Text(
                      'Outfit Details',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: espresso,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: AspectRatio(
                          aspectRatio: 0.78,
                          child: Image.network(
                            outfit.imageURL,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;

                              return const Center(
                                child: CircularProgressIndicator(
                                  color: berry,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 45,
                                    color: berry,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: coral.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categoryName,
                          style: const TextStyle(
                            color: berry,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        outfit.title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: espresso,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        outfit.description.isEmpty
                            ? 'Explore this look and discover your personal style.'
                            : outfit.description,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Color(0xFF6F625D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
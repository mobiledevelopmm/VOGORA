
import 'package:flutter/material.dart';

import '../../../../data/models/outfit_item_model.dart';

class OutfitGridCard extends StatelessWidget {
  final OutfitItem item;

  const OutfitGridCard({
    super.key,
    required this.item,
  });

  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);
  static const Color secondary = Color(0xFF6F625D);
  static const Color imageBackground = Color(0xFFF1D8D8);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Image.network(
              item.imageURL,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                }

                return Container(
                  color: imageBackground,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: berry,
                    strokeWidth: 2,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                debugPrint('========== IMAGE ERROR ==========');
                debugPrint('Image URL: ${item.imageURL}');
                debugPrint('Error: $error');
                debugPrint('=================================');

                return Container(
                  width: double.infinity,
                  color: imageBackground,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.checkroom_rounded,
                    size: 45,
                    color: berry,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: espresso,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          item.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 10,
            color: secondary,
          ),
        ),
      ],
    );
  }
}
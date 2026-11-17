
import 'package:flutter/material.dart';

import '../models/outfit_item.dart';

class OutfitGridCard extends StatelessWidget {
  final OutfitItem item;

  const OutfitGridCard({
    super.key,
    required this.item,
  });

  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);
  static const Color secondary = Color(0xFF6F625D);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Image.network(
              item.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;

                return Container(
                  color: const Color(0xFFF1D8D8),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: berry,
                    strokeWidth: 2,
                  ),
                );
              },
              errorBuilder: (_, __, ___) {
                return Container(
                  width: double.infinity,
                  color: const Color(0xFFF1D8D8),
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

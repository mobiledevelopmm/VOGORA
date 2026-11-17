
import 'package:flutter/material.dart';

import '../auth/widgets/fashion_background.dart';

class SavedOutfitsPage extends StatelessWidget {
  const SavedOutfitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FashionBackground(
      overlayOpacity: 0.82,
      child: const SafeArea(
        child: Center(
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF29211F),
            ),
          ),
        ),
      ),
    );
  }
}

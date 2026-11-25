
import 'package:flutter/material.dart';

import '../../../auth/widgets/fashion_background.dart';

class BodyShapeResultPage extends StatelessWidget {
  final String bodyShape;
  final String gender;
  final String undertone;

  const BodyShapeResultPage({
    super.key,
    required this.bodyShape,
    required this.gender,
    required this.undertone,
  });

  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);
  static const Color secondary = Color(0xFF796B65);
  static const Color coral = Color(0xFFFF5E62);

  String get description {
    switch (bodyShape) {
      case 'Hourglass':
        return 'Your upper and lower body measurements are balanced, '
            'with a more defined waist. Your proportions create a '
            'naturally balanced silhouette.';

      case 'Pear':
        return 'Your hip measurement is more prominent than your '
            'upper body. Styling that adds visual balance to your '
            'upper body may complement your proportions.';

      case 'Rectangle':
        return 'Your upper body, waist and hip measurements are '
            'relatively balanced. You can experiment with styles '
            'that create curves or add dimension.';

      case 'Inverted Triangle':
        return 'Your upper body measurement is more prominent than '
            'your hips. Outfits that add visual volume to the lower '
            'body can create a balanced look.';

      case 'Apple':
        return 'Your waist measurement is relatively prominent '
            'compared with your upper and lower body measurements. '
            'Comfortable, well-balanced silhouettes may suit you.';

      default:
        return 'Your measurements have been used to estimate '
            'your body shape.';
    }
  }

  List<String> get stylingTips {
    switch (bodyShape) {
      case 'Hourglass':
        return [
          'Try fitted tops and wrap dresses.',
          'Highlight your waist with belts.',
          'Explore high-waisted trousers and skirts.',
        ];

      case 'Pear':
        return [
          'Try statement tops and interesting necklines.',
          'Explore A-line skirts and wide-leg trousers.',
          'Use balanced colours and details in your outfits.',
        ];

      case 'Rectangle':
        return [
          'Experiment with layered outfits.',
          'Try belted dresses and peplum tops.',
          'Explore different textures and silhouettes.',
        ];

      case 'Inverted Triangle':
        return [
          'Try V-neck and simple neckline designs.',
          'Explore wide-leg trousers and A-line skirts.',
          'Add visual details around the hip area.',
        ];

      case 'Apple':
        return [
          'Try V-neck and open-neckline tops.',
          'Explore straight-leg or wide-leg trousers.',
          'Experiment with flowing and structured layers.',
        ];

      default:
        return [
          'Experiment with different outfit silhouettes.',
          'Choose comfortable and well-fitted clothes.',
          'Wear styles that express your personality.',
        ];
    }
  }

  IconData get shapeIcon {
    switch (bodyShape) {
      case 'Hourglass':
        return Icons.hourglass_empty_rounded;
      case 'Pear':
        return Icons.change_history_rounded;
      case 'Rectangle':
        return Icons.crop_16_9_rounded;
      case 'Inverted Triangle':
        return Icons.filter_vintage_rounded;
      case 'Apple':
        return Icons.circle_outlined;
      default:
        return Icons.checkroom_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FashionBackground(
      overlayOpacity: 0.88,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: berry,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'YOUR BODY SHAPE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: berry,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 25),

                // Result introduction
                const Center(
                  child: Text(
                    'Your Style Starts With You',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: espresso,
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    'We have estimated your body shape!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: secondary,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Main result card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFD6C9),
                        Color(0xFFF3B9B2),
                        Color(0xFFE8B6B8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: berry.withValues(alpha: 0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.65),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          shapeIcon,
                          color: berry,
                          size: 48,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'YOUR BODY SHAPE IS',
                        style: TextStyle(
                          color: berry,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        bodyShape,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: espresso,
                          fontSize: 29,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: espresso,
                          fontSize: 12,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // User information
                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFE9D9D6),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'YOUR STYLE PROFILE',
                        style: TextStyle(
                          color: berry,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _infoRow(
                        Icons.person_outline_rounded,
                        'Gender',
                        gender,
                      ),
                      const SizedBox(height: 12),
                      _infoRow(
                        Icons.palette_outlined,
                        'Undertone',
                        undertone,
                      ),
                      const SizedBox(height: 12),
                      _infoRow(
                        Icons.accessibility_new_rounded,
                        'Body Shape',
                        bodyShape,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Styling tips
                const Text(
                  'Styling Tips For You',
                  style: TextStyle(
                    color: espresso,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Ideas to help you explore your personal style.',
                  style: TextStyle(
                    color: secondary,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 15),

                ...stylingTips.map(
                      (tip) => Container(
                    margin: const EdgeInsets.only(bottom: 11),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: coral,
                          size: 19,
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Text(
                            tip,
                            style: const TextStyle(
                              color: espresso,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // Back to Home
                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: berry,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                const Center(
                  child: Text(
                    'Your body shape is a styling guide, not a limitation.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: secondary,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          color: berry,
          size: 19,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: secondary,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: espresso,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
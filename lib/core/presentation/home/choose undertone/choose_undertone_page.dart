import 'package:flutter/material.dart';

import '../../auth/widgets/fashion_background.dart';
import '../body measurements/body_measurements_page.dart';
class ChooseUndertonePage extends StatefulWidget {
  const ChooseUndertonePage({super.key});

  @override
  State<ChooseUndertonePage> createState() =>
      _ChooseUndertonePageState();
}

class _ChooseUndertonePageState
    extends State<ChooseUndertonePage> {
  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);
  static const Color secondary = Color(0xFF796B65);

  String? selectedUndertone;

  final List<_UndertoneOption> undertones = [
    _UndertoneOption(
      name: 'Cool',
      description: 'Pink, red or bluish undertones',
      detail: 'Colors like lavender, blue and rose may suit you.',
      icon: Icons.ac_unit_rounded,
      background: Color(0xFFE9EDF8),
      accent: Color(0xFF7186B5),
      palette: [
        Color(0xFFB8C8E5),
        Color(0xFF899CC5),
        Color(0xFFD5B9D8),
        Color(0xFFE7C5CC),
      ],
    ),
    _UndertoneOption(
      name: 'Warm',
      description: 'Golden, yellow or peach undertones',
      detail: 'Colors like coral, olive and warm beige may suit you.',
      icon: Icons.wb_sunny_rounded,
      background: Color(0xFFF9E9DA),
      accent: Color(0xFFB8794A),
      palette: [
        Color(0xFFE6AD83),
        Color(0xFFD18B65),
        Color(0xFFB5A16E),
        Color(0xFFE9D1A7),
      ],
    ),
    _UndertoneOption(
      name: 'Neutral',
      description: 'A balance of cool and warm undertones',
      detail: 'You may enjoy a balanced mix of soft colors.',
      icon: Icons.balance_rounded,
      background: Color(0xFFE9EDE5),
      accent: Color(0xFF75866D),
      palette: [
        Color(0xFFB5BDAA),
        Color(0xFFC9B6A6),
        Color(0xFFD6B7B5),
        Color(0xFFAAA99B),
      ],
    ),
  ];

  void _continue() {
    if (selectedUndertone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose your undertone first.'),
          backgroundColor: berry,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BodyMeasurementsPage(
          undertone: selectedUndertone!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FashionBackground(
      overlayOpacity: 0.90,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    22, 22, 22, 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'VOGORA',
                          style: TextStyle(
                            color: berry,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Icon(
                          Icons.palette_outlined,
                          color: berry,
                          size: 43,
                        ),
                      ),
                      const SizedBox(height: 13),
                      const Text(
                        'Discover Your\\nPerfect Color Story',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: espresso,
                          fontSize: 27,
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Choose your skin undertone to help us '
                            'suggest colors that complement your look.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: secondary,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 25),

                      ...undertones.map(
                            (option) => Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: _buildUndertoneCard(option),
                        ),
                      ),

                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          'Not sure? You can explore and change '
                              'your choice later.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: secondary,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE8DAD5),
              ),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: espresso,
                size: 17,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'STYLE PERSONALIZATION',
            style: TextStyle(
              color: secondary,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 42),
        ],
      ),
    );
  }

  Widget _buildUndertoneCard(_UndertoneOption option) {
    final isSelected = selectedUndertone == option.name;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedUndertone = option.name;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: option.background.withValues(
            alpha: isSelected ? 1 : 0.78,
          ),
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: isSelected
                ? option.accent
                : Colors.white.withValues(alpha: 0.9),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: option.accent.withValues(alpha: 0.09),
              blurRadius: 13,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                option.icon,
                color: option.accent,
                size: 27,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.name,
                    style: TextStyle(
                      color: option.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    option.description,
                    style: const TextStyle(
                      color: espresso,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: option.palette.map((color) {
                      return Container(
                        width: 18,
                        height: 18,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    option.detail,
                    style: const TextStyle(
                      color: secondary,
                      fontSize: 9,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              isSelected
                  ? Icons.check_circle_rounded
                  : Icons.circle_outlined,
              color: isSelected ? option.accent : Colors.black26,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 18),
      child: SizedBox(
        width: double.infinity,
        height: 53,
        child: ElevatedButton(
          onPressed: _continue,
          style: ElevatedButton.styleFrom(
            backgroundColor: berry,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(width: 9),
              Icon(Icons.arrow_forward_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _UndertoneOption {
  final String name;
  final String description;
  final String detail;
  final IconData icon;
  final Color background;
  final Color accent;
  final List<Color> palette;

  const _UndertoneOption({
    required this.name,
    required this.description,
    required this.detail,
    required this.icon,
    required this.background,
    required this.accent,
    required this.palette,
  });
}
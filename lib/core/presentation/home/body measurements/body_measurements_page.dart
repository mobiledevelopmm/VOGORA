
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';
import '../../auth/widgets/fashion_background.dart';
import 'body_shape_result_page.dart';

class BodyMeasurementsPage extends StatefulWidget {
  final String undertone;

  const BodyMeasurementsPage({
    super.key,
    required this.undertone,
  });

  @override
  State<BodyMeasurementsPage> createState() =>
      _BodyMeasurementsPageState();
}

class _BodyMeasurementsPageState extends State<BodyMeasurementsPage> {
  static const Color coral = Color(0xFFFF5E62);
  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);
  static const Color secondary = Color(0xFF796B65);
  static const Color softRose = Color(0xFFF7E9E7);

  final _formKey = GlobalKey<FormState>();

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _shoulderController = TextEditingController();
  final _bustController = TextEditingController();
  final _waistController = TextEditingController();
  final _hipController = TextEditingController();

  String _unit = 'cm';

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _shoulderController.dispose();
    _bustController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    super.dispose();
  }

  void _changeUnit(String newUnit) {
    if (_unit == newUnit) return;

    final controllers = [
      _heightController,
      _shoulderController,
      _bustController,
      _waistController,
      _hipController,
    ];

    for (final controller in controllers) {
      final value = double.tryParse(controller.text);

      if (value != null) {
        final converted = newUnit == 'in'
            ? value / 2.54
            : value * 2.54;

        controller.text = converted.toStringAsFixed(1);
      }
    }

    setState(() {
      _unit = newUnit;
    });
  }

  String? _validateMeasurement(
      String? value, {
        required bool required,
      }) {
    if (value == null || value.trim().isEmpty) {
      return required ? 'This measurement is required' : null;
    }

    final number = double.tryParse(value);

    if (number == null || number <= 0) {
      return 'Enter a valid measurement';
    }

    return null;
  }


  void _onCalculate() {
    if (!_formKey.currentState!.validate()) return;

    // Read user measurements.
    double bust = double.parse(_bustController.text);
    double waist = double.parse(_waistController.text);
    double hip = double.parse(_hipController.text);

    // Convert inches to centimetres for calculation.
    if (_unit == 'in') {
      bust *= 2.54;
      waist *= 2.54;
      hip *= 2.54;
    }

    final bodyShape = _calculateBodyShape(
      bust: bust,
      waist: waist,
      hip: hip,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BodyShapeResultPage(
          bodyShape: bodyShape,
          gender: context.read<AuthCubit>().state.userGender ?? 'Female',
          undertone: widget.undertone,
        ),
      ),
    );
  }

  String _calculateBodyShape({
    required double bust,
    required double waist,
    required double hip,
  }) {
    final upperLowerDifference =
        (bust - hip).abs() / ((bust + hip) / 2);

    final upperLowerBalanced = upperLowerDifference <= 0.05;

    final definedWaist =
        waist <= bust * 0.75 &&
            waist <= hip * 0.75;

    final prominentWaist =
        waist >= bust * 0.90 &&
            waist >= hip * 0.90;

    if (prominentWaist) {
      return 'Apple';
    }

    if (upperLowerBalanced && definedWaist) {
      return 'Hourglass';
    }

    if (upperLowerBalanced) {
      return 'Rectangle';
    }

    if (hip > bust * 1.05) {
      return 'Pear';
    }

    if (bust > hip * 1.05) {
      return 'Inverted Triangle';
    }

    return 'Rectangle';
  }

  Widget _buildMeasurementField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool required,
    required String suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: espresso,
              ),
            ),
            if (required)
              const Text(
                ' *',
                style: TextStyle(
                  color: coral,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  'Optional',
                  style: TextStyle(
                    color: secondary,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*'),
            ),
          ],
          validator: (value) => _validateMeasurement(
            value,
            required: required,
          ),
          decoration: InputDecoration(
            hintText: hint,
            suffixText: suffix,
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.85),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            hintStyle: const TextStyle(
              color: Color(0xFFB4A7A2),
              fontSize: 12,
            ),
            suffixStyle: const TextStyle(
              color: berry,
              fontWeight: FontWeight.w700,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color(0xFFE9D9D6),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color(0xFFE9D9D6),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: berry,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: coral,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(
      String title,
      String subtitle,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: espresso,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: secondary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final gender =
        context.watch<AuthCubit>().state.userGender ?? 'Female';

    final isMale = gender.toLowerCase() == 'male';

    return FashionBackground(
      overlayOpacity: 0.88,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: berry,
                        size: 20,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'BODY MEASUREMENTS',
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
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    22, 12, 22, 28,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Introduction
                        const Text(
                          'Let’s Find Your\nBody Shape',
                          style: TextStyle(
                            color: espresso,
                            fontSize: 27,
                            height: 1.2,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 9),
                        const Text(
                          'Enter your body measurements to discover '
                              'the styles that complement your shape.',
                          style: TextStyle(
                            color: secondary,
                            fontSize: 12,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Gender and undertone information
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: softRose.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.checkroom_rounded,
                                color: berry,
                                size: 25,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      gender,
                                      style: const TextStyle(
                                        color: espresso,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Undertone: ${widget.undertone}',
                                      style: const TextStyle(
                                        color: secondary,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Unit selection
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSectionTitle(
                              'Measurement Unit',
                              'Choose your preferred unit',
                            ),
                            Row(
                              children: [
                                _unitChip('cm'),
                                const SizedBox(width: 7),
                                _unitChip('in'),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Optional measurements
                        _buildSectionTitle(
                          'Additional Information',
                          'You can skip these if you do not know them.',
                        ),

                        const SizedBox(height: 15),

                        _buildMeasurementField(
                          label: 'Height',
                          hint: 'Enter your height',
                          controller: _heightController,
                          required: false,
                          suffix: _unit,
                        ),

                        const SizedBox(height: 15),

                        _buildMeasurementField(
                          label: 'Weight',
                          hint: 'Enter your weight',
                          controller: _weightController,
                          required: false,
                          suffix: 'kg',
                        ),

                        const SizedBox(height: 15),

                        _buildMeasurementField(
                          label: 'Shoulder',
                          hint: 'Enter shoulder measurement',
                          controller: _shoulderController,
                          required: false,
                          suffix: _unit,
                        ),

                        const SizedBox(height: 25),

                        // Required measurements
                        _buildSectionTitle(
                          'Body Shape Measurements',
                          'These three measurements are required.',
                        ),

                        const SizedBox(height: 15),

                        _buildMeasurementField(
                          label: isMale ? 'Chest' : 'Bust',
                          hint: 'Enter your ${isMale ? 'chest' : 'bust'} measurement',
                          controller: _bustController,
                          required: true,
                          suffix: _unit,
                        ),

                        const SizedBox(height: 15),

                        _buildMeasurementField(
                          label: 'Waist',
                          hint: 'Enter your waist measurement',
                          controller: _waistController,
                          required: true,
                          suffix: _unit,
                        ),

                        const SizedBox(height: 15),

                        _buildMeasurementField(
                          label: 'Hip',
                          hint: 'Enter your hip measurement',
                          controller: _hipController,
                          required: true,
                          suffix: _unit,
                        ),

                        const SizedBox(height: 13),

                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: berry,
                              size: 16,
                            ),
                            SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                'Bust/Chest, Waist and Hip are required '
                                    'to calculate your body shape.',
                                style: TextStyle(
                                  color: secondary,
                                  fontSize: 10,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Calculate button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _onCalculate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: berry,
                              foregroundColor: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Calculate My Body Shape',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(width: 9),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 19,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Center(
                          child: Text(
                            'Your measurements are used for styling recommendations.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: secondary,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _unitChip(String unit) {
    final isSelected = _unit == unit;

    return GestureDetector(
      onTap: () => _changeUnit(unit),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: isSelected ? berry : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? berry : const Color(0xFFE9D9D6),
          ),
        ),
        child: Text(
          unit,
          style: TextStyle(
            color: isSelected ? Colors.white : secondary,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../auth/cubit/auth_cubit.dart';
import '../auth/cubit/auth_state.dart';
import '../auth/widgets/fashion_background.dart';

class GenderSelectionPage extends StatefulWidget {
  const GenderSelectionPage({super.key});

  @override
  State<GenderSelectionPage> createState() =>
      _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<GenderSelectionPage> {
  String? selectedGender;

  static const Color berry = Color(0xFF91475B);
  static const Color coral = Color(0xFFFF5E62);
  static const Color espresso = Color(0xFF29211F);

  void _continue() {
    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your gender to continue.'),
          backgroundColor: berry,
        ),
      );
      return;
    }

    context.read<AuthCubit>().saveGender(selectedGender!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go('/home');
        }

        if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? 'Unable to save your selection.',
              ),
              backgroundColor: berry,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;

        return FashionBackground(
          overlayOpacity: 0.82,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 30,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'VOGORA',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 5,
                            color: berry,
                          ),
                        ),
                        const SizedBox(height: 45),
                        const Icon(
                          Icons.person_pin_circle_outlined,
                          size: 65,
                          color: berry,
                        ),
                        const SizedBox(height: 22),
                        const Text(
                          'Let’s Get to Know You',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: espresso,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Select your gender to help us personalize '
                              'your fashion recommendations.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Color(0xFF6F625D),
                          ),
                        ),
                        const SizedBox(height: 35),

                        // Male option
                        _genderCard(
                          gender: 'Male',
                          icon: Icons.male_rounded,
                        ),

                        const SizedBox(height: 16),

                        // Female option
                        _genderCard(
                          gender: 'Female',
                          icon: Icons.female_rounded,
                        ),

                        const SizedBox(height: 35),

                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _continue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: berry,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor:
                              berry.withValues(alpha: 0.5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                              width: 23,
                              height: 23,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                                : const Text(
                              'CONTINUE',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _genderCard({
    required String gender,
    required IconData icon,
  }) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? berry.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? berry : Colors.white,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 34,
              color: isSelected ? berry : coral,
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                gender,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? berry : espresso,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: isSelected ? berry : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/presentation/pages/auth/widgets/fashion_background.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/auth_state.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/auth_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  void _register() {
    FocusScope.of(context).unfocus();

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    String? errorMessage;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      errorMessage = 'Please fill in all fields.';
    } else if (!email.contains('@') || !email.contains('.')) {
      errorMessage = 'Please enter a valid email address.';
    } else if (password.length < 6) {
      errorMessage = 'Password must be at least 6 characters.';
    } else if (password != confirmPassword) {
      errorMessage = 'Passwords do not match.';
    }

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: const Color(0xFF91475B),
        ),
      );
      return;
    }

    context.read<AuthCubit>().register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.needsGenderSelection) {
          context.go('/gender-selection');
        }

        if (state.status == AuthStatus.authenticated) {
          context.go('/home');
        }

        if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? 'Registration failed.',
              ),
              backgroundColor: const Color(0xFF91475B),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: FashionBackground(
              overlayOpacity: 0.70,
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 24,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),

                          const Center(
                            child: Text(
                              'VOGORA',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 5,
                                color: Color(0xFF91475B),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF29211F),
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Create your account and discover your personal style.',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFF6F625D),
                            ),
                          ),

                          const SizedBox(height: 28),

                          AuthTextField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            controller: _nameController,
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                          ),

                          const SizedBox(height: 18),

                          AuthTextField(
                            label: 'Email Address',
                            hint: 'Enter your email',
                            controller: _emailController,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 18),

                          AuthTextField(
                            label: 'Password',
                            hint: 'Create a password',
                            controller: _passwordController,
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            obscureText: !_passwordVisible,
                            onTogglePassword: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          AuthTextField(
                            label: 'Confirm Password',
                            hint: 'Re-enter your password',
                            controller: _confirmPasswordController,
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            obscureText: !_confirmPasswordVisible,
                            onTogglePassword: () {
                              setState(() {
                                _confirmPasswordVisible =
                                !_confirmPasswordVisible;
                              });
                            },
                          ),

                          const SizedBox(height: 28),

                          AuthButton(
                            title: 'CREATE ACCOUNT',
                            isLoading: isLoading,
                            onPressed: _register,
                          ),

                          const SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Flexible(
                                child: Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6F625D),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: isLoading ? null : () => context.go('/login'),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF91475B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
}

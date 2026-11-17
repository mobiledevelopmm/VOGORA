
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../auth/cubit/auth_cubit.dart';
import '../auth/cubit/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.06,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();

    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    // Show splash for 3 seconds.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authCubit = context.read<AuthCubit>();

    // Check current authentication state.
    var authState = authCubit.state;

    // Wait until Firebase restores the authentication state.
    if (authState.status == AuthStatus.initial ||
        authState.status == AuthStatus.loading) {
      authState = await authCubit.stream.firstWhere(
            (state) =>
        state.status == AuthStatus.authenticated ||
            state.status == AuthStatus.unauthenticated ||
            state.status == AuthStatus.error,
      );
    }

    if (!mounted) return;

    // Navigate based on authentication status.
    if (authState.status == AuthStatus.authenticated) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'assets/images/vogora_splash.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(
                  color: Color(0xFFFF5E62),
                  child: Center(
                    child: Text(
                      'VOGORA',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

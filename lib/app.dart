
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/data/services/auth_service.dart';
import 'core/presentation/auth/cubit/auth_cubit.dart';
import 'core/presentation/home/theme/app_theme.dart';
import 'core/presentation/router/app_router.dart';

class VogoraApp extends StatelessWidget {
  const VogoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthService()),
      child: MaterialApp.router(
        title: 'VOGORA',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

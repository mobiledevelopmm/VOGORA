
import 'package:go_router/go_router.dart';
import '../main_screen.dart';
import '../pages/gender selection/gender_selection_page.dart';
import '../pages/authentication/login_page.dart';
import '../pages/authentication/register_page.dart';
import '../pages/splash/splash_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/gender-selection',
        name: 'gender-selection',
        builder: (context, state) => const GenderSelectionPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}

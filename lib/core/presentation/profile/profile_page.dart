
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/presentation/profile/pages/personal_information_page.dart';

import '../auth/cubit/auth_cubit.dart';
import '../auth/cubit/auth_state.dart';
import '../auth/widgets/fashion_background.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color espresso = Color(0xFF29211F);
  static const Color coral = Color(0xFFFF5E62);
  static const Color peach = Color(0xFFFF9966);
  static const Color berry = Color(0xFF91475B);
  static const Color dustyRose = Color(0xFFD7AAA5);
  static const Color ivory = Color(0xFFFFFAF5);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          context.go('/login');
        }
      },
      builder: (context, state) {
        return FashionBackground(
          overlayOpacity: 0.88,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 26),
                  _buildProfileCard(
                    userName: state.userName ?? 'User',
                    userEmail: state.userEmail ?? '',
                  ),
                  const SizedBox(height: 28),
                  _buildSectionTitle('MY STYLE PROFILE'),
                  const SizedBox(height: 14),
                  _buildMenuCard(
                    icon: Icons.person_outline_rounded,
                    title: 'Personal Information',
                    subtitle: 'Your personal details and account information',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PersonalInformationPage(),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.palette_outlined,
                    title: 'Skin Tone',
                    subtitle: 'Your skin tone and undertone',
                    onTap: () {},
                  ),
                  _buildMenuCard(
                    icon: Icons.straighten_rounded,
                    title: 'Body Profile',
                    subtitle: 'Your body shape and measurements',
                    onTap: () {},
                  ),
                  _buildMenuCard(
                    icon: Icons.checkroom_outlined,
                    title: 'Style Preference',
                    subtitle: 'Your favorite fashion styles',
                    onTap: () {},
                  ),
                  const SizedBox(height: 28),
                  _buildSectionTitle('ACCOUNT'),
                  const SizedBox(height: 14),
                  _buildLogoutButton(context, state),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'VOGORA  •  YOUR PERSONAL STYLE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: espresso.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MY ACCOUNT',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w800,
            color: berry,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'My Profile',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: espresso,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard({
    required String userName,
    required String userEmail,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            berry,
            Color(0xFFB86A70),
            dustyRose,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: berry.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ivory,
                      border: Border.all(
                        color: ivory.withValues(alpha: 0.9),
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 43,
                      color: berry,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: const BoxDecoration(
                        color: peach,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 14,
                        color: espresso,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ivory,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (userEmail.isNotEmpty)
                      Text(
                        userEmail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: ivory,
                          fontSize: 11,
                        ),
                      ),
                    const SizedBox(height: 10),
                    const Text(
                      'EDIT PROFILE  →',
                      style: TextStyle(
                        color: ivory,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: ivory.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: ivory,
                  size: 19,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Your personal style journey starts here.',
                    style: TextStyle(
                      color: ivory,
                      fontSize: 11,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ivory,
                  size: 13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: berry,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: ivory.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: dustyRose.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: espresso.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(19),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    color: dustyRose.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    color: berry,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: espresso,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: espresso.withValues(alpha: 0.55),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: espresso.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(
      BuildContext context,
      AuthState state,
      ) {
    final isLoading = state.status == AuthStatus.loading;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ivory.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: coral.withValues(alpha: 0.25),
        ),
      ),
      child: InkWell(
        onTap: isLoading
            ? null
            : () => _confirmLogout(context),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 17,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.logout_rounded,
                color: coral,
                size: 21,
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: coral,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (isLoading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: coral,
                  ),
                )
              else
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: coral,
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: ivory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Log Out?',
            style: TextStyle(
              color: espresso,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'Are you sure you want to log out of your account?',
            style: TextStyle(
              color: espresso,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: berry),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: coral,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true && context.mounted) {
      await context.read<AuthCubit>().logout();
    }
  }
}

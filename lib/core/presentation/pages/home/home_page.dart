
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/outfit_item_model.dart';
import '../../../data/services/style_profile_service.dart';
import '../auth/cubit/auth_cubit.dart';
import '../auth/widgets/fashion_background.dart';
import '../choose undertone/choose_undertone_page.dart';
import '../choose undertone/cubit/choose_undertone_cubit.dart';
import '../styled_for_you/styled_for_you_page.dart';
import '../trending_styles/trending_styles_page.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onOpenProfile;

  const HomePage({
    super.key,
    required this.onOpenProfile,
  });

  static const Color coral = Color(0xFFFF5E62);
  static const Color berry = Color(0xFF91475B);
  static const Color espresso = Color(0xFF29211F);
  static const Color secondary = Color(0xFF6F625D);

  void _openCollection(
      BuildContext context, {
        required bool isTrending,
        String? category,
      }) {
    final gender =
        context.read<AuthCubit>().state.userGender ?? 'Female';

    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) {
          if (isTrending) {
            return TrendingStylesPage(
              gender: gender,
            );
          }

          return StyledForYouPage(
            gender: gender,
            initialCategory: category,
          );
        },
      ),
    );
  }

  void _openUndertonePage(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => ChooseUndertoneCubit(
            StyleProfileService(),
          ),
          child: const ChooseUndertonePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    final double previewHeight =
    (screenHeight * 0.205).clamp(155.0, 185.0).toDouble();

    return FashionBackground(
      overlayOpacity: 0.84,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'VOGORA',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                          color: berry,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Hello, Fashion Lover 👋',
                        style: TextStyle(
                          fontSize: 12,
                          color: espresso.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFF1D8D8),
                    child: IconButton(
                      onPressed: onOpenProfile,
                      icon: const Icon(
                        Icons.person_outline_rounded,
                        color: berry,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Inspiration Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(19, 17, 19, 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFD6C9),
                      Color(0xFFF3B9B2),
                      Color(0xFFE8B6B8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: berry.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'YOUR STYLE, YOUR STORY',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.7,
                              color: berry,
                            ),
                          ),
                          const SizedBox(height: 9),
                          const Text(
                            'Discover the Style\nThat Feels Like You.',
                            style: TextStyle(
                              fontSize: 22,
                              height: 1.2,
                              fontWeight: FontWeight.w800,
                              color: espresso,
                            ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            'Explore outfits made for your personality.',
                            style: TextStyle(
                              fontSize: 10,
                              color: secondary,
                            ),
                          ),
                          const SizedBox(height: 13),
                          ElevatedButton(
                            onPressed: () =>
                                _openUndertonePage(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: berry,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Explore My Style',
                                  style: TextStyle(fontSize: 11),
                                ),
                                SizedBox(width: 7),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.checkroom_rounded,
                      size: 76,
                      color: Color(0x6691475B),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 23),

              // Styled for You
              _sectionHeader(
                title: 'Styled for You',
                subtitle: 'Looks selected for your personal style',
                onSeeAll: () => _openCollection(
                  context,
                  isTrending: false,
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: previewHeight,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return _buildOutfitPreview(
                      context,
                      state: state,
                      outfits: state.styledOutfits,
                      isTrending: false,
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),

              // Trending Styles
              _sectionHeader(
                title: 'Trending Styles',
                subtitle: 'Popular looks and fashion inspiration',
                onSeeAll: () => _openCollection(
                  context,
                  isTrending: true,
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: previewHeight,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return _buildOutfitPreview(
                      context,
                      state: state,
                      outfits: state.trendingOutfits,
                      isTrending: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Outfit preview with loading, error and empty states
  Widget _buildOutfitPreview(
      BuildContext context, {
        required HomeState state,
        required List<OutfitItem> outfits,
        required bool isTrending,
      }) {
    if (state.status == HomeStatus.initial ||
        state.status == HomeStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: coral,
          strokeWidth: 3,
        ),
      );
    }

    if (state.status == HomeStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              color: berry,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              state.errorMessage ?? 'Unable to load outfits.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: espresso,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {
                final gender =
                    context.read<AuthCubit>().state.userGender ??
                        'Female';

                context.read<HomeCubit>().retry(gender);
              },
              child: const Text(
                'Try Again',
                style: TextStyle(
                  color: coral,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (outfits.isEmpty) {
      return Center(
        child: Text(
          'No outfits available yet.',
          style: TextStyle(
            color: espresso.withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: outfits.length,
      itemBuilder: (context, index) {
        final outfit = outfits[index];

        return Padding(
          padding: const EdgeInsets.only(right: 13),
          child: _PreviewCard(
            title: isTrending
                ? outfit.title
                : outfit.category.isNotEmpty
                ? outfit.category
                : outfit.title,
            subtitle: outfit.description.isNotEmpty
                ? outfit.description
                : outfit.title,
            imageUrl: outfit.imageURL,
            onTap: () => _openCollection(
              context,
              isTrending: isTrending,
              category: isTrending ? null : outfit.category,
            ),
          ),
        );
      },
    );
  }

  Widget _sectionHeader({
    required String title,
    required String subtitle,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: espresso,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: secondary,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
            foregroundColor: coral,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Row(
            children: [
              Text(
                'See All',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback onTap;

  const _PreviewCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 190,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF1D8D8),
                    child: const Icon(
                      Icons.checkroom_rounded,
                      size: 45,
                      color: HomePage.berry,
                    ),
                  );
                },
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xCC29211F),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                right: 12,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
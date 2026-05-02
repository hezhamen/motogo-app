import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/home/components/home_bottom_navigation.dart';
import 'package:motogo_app/features/home/components/home_header.dart';
import 'package:motogo_app/features/home/components/popular_brands_section.dart';
import 'package:motogo_app/features/home/components/sponsored_section.dart';

/// Displays the Motogo home feed.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewPadding = MediaQuery.paddingOf(context);
    final double headerHeight = viewPadding.top + 74;
    final double bottomNavHeight = viewPadding.bottom + 91;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: headerHeight + 16),
                  ),
                  const SliverToBoxAdapter(child: PopularBrandsSection()),
                  const SliverToBoxAdapter(child: SizedBox(height: 18)),
                  const SliverToBoxAdapter(child: SponsoredSection()),
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: bottomNavHeight + 20),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: HomeHeader(height: headerHeight),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: HomeBottomNavigation(height: bottomNavHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

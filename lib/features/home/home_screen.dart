import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/post_car/post_car_flow.dart';
import 'package:motogo_app/features/home/components/home_header.dart';
import 'package:motogo_app/features/home/components/popular_brands_section.dart';
import 'package:motogo_app/features/home/components/sponsored_section.dart';
import 'package:motogo_app/features/home/models/home_feed_layout.dart';

/// Displays the Motogo home feed.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeFeedLayout _feedLayout = HomeFeedLayout.grid;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewPadding = MediaQuery.paddingOf(context);
    final double headerHeight = viewPadding.top + 74;
    final double bottomNavHeight = viewPadding.bottom + 91;

    return Scaffold(
      backgroundColor: context.appBackground,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: headerHeight)),
              const SliverToBoxAdapter(child: PopularBrandsSection()),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: SponsoredSection(layout: _feedLayout)),
              SliverPadding(
                padding: EdgeInsets.only(bottom: bottomNavHeight + 20),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: HomeHeader(
              height: headerHeight,
              feedLayout: _feedLayout,
              onFeedLayoutChanged: (layout) {
                setState(() {
                  _feedLayout = layout;
                });
              },
              onCreateListing: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const PostCarFlow()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

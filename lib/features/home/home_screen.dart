import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/post_car/post_car_flow.dart';
import 'package:motogo_app/features/home/components/home_header.dart';
import 'package:motogo_app/features/home/components/popular_brands_section.dart';
import 'package:motogo_app/features/home/components/sponsored_section.dart';
import 'package:motogo_app/features/home/models/home_feed_layout.dart';

/// Displays the Motogo home feed.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onBottomNavVisibilityChanged});

  final ValueChanged<bool>? onBottomNavVisibilityChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeFeedLayout _feedLayout = HomeFeedLayout.grid;
  bool? _lastBottomNavVisible;

  void _setBottomNavVisible(bool visible) {
    if (_lastBottomNavVisible == visible) return;
    _lastBottomNavVisible = visible;
    widget.onBottomNavVisibilityChanged?.call(visible);
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewPadding = MediaQuery.paddingOf(context);
    final double headerHeight = viewPadding.top + 64;
    final double bottomNavHeight = viewPadding.bottom + 91;

    return Scaffold(
      backgroundColor: context.appBackground,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (n) {
          switch (n.direction) {
            case ScrollDirection.forward:
              _setBottomNavVisible(true);
            case ScrollDirection.reverse:
              _setBottomNavVisible(false);
            case ScrollDirection.idle:
              break;
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _HomeHeaderDelegate(
                height: headerHeight,
                feedLayout: _feedLayout,
                onFeedLayoutChanged: (layout) => setState(() {
                  _feedLayout = layout;
                }),
                onCreateListing: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const PostCarFlow(),
                    ),
                  );
                },
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _PopularBrandsDelegate(
                backgroundColor: context.appBackground,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(child: SponsoredSection(layout: _feedLayout)),
            SliverPadding(
              padding: EdgeInsets.only(bottom: bottomNavHeight + 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  _HomeHeaderDelegate({
    required this.height,
    required this.feedLayout,
    required this.onFeedLayoutChanged,
    required this.onCreateListing,
  });

  final double height;
  final HomeFeedLayout feedLayout;
  final ValueChanged<HomeFeedLayout> onFeedLayoutChanged;
  final VoidCallback onCreateListing;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return HomeHeader(
      height: height,
      feedLayout: feedLayout,
      onFeedLayoutChanged: onFeedLayoutChanged,
      onCreateListing: onCreateListing,
    );
  }

  @override
  bool shouldRebuild(covariant _HomeHeaderDelegate oldDelegate) {
    return oldDelegate.height != height ||
        oldDelegate.feedLayout != feedLayout ||
        oldDelegate.onFeedLayoutChanged != onFeedLayoutChanged ||
        oldDelegate.onCreateListing != onCreateListing;
  }
}

class _PopularBrandsDelegate extends SliverPersistentHeaderDelegate {
  _PopularBrandsDelegate({required this.backgroundColor});

  final Color backgroundColor;

  // Note: keep a little headroom to avoid sub-pixel overflow on some devices.
  // Expanded content ~ (topPadding 16) + (listHeight 82) = 98.
  // Collapsed content ~ (topPadding 10) + (listHeight 56) = 66.
  static const double _expandedHeight = 100;
  static const double _collapsedHeight = 66;

  @override
  double get minExtent => _collapsedHeight;

  @override
  double get maxExtent => _expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double t = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);

    return ColoredBox(
      color: backgroundColor,
      child: PopularBrandsSection(collapseT: t),
    );
  }

  @override
  bool shouldRebuild(covariant _PopularBrandsDelegate oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor;
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_widgets.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({
    super.key,
    required this.height,
    required this.onProfileTap,
  });

  final double height;
  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return AppBottomNavigation(
      height: height,
      items: [
        const AppBottomNavigationItem(
          icon: LucideIcons.house,
          label: 'Home',
          isSelected: true,
        ),
        const AppBottomNavigationItem(
          icon: LucideIcons.search,
          label: 'Search',
        ),
        const AppBottomNavigationItem(
          icon: LucideIcons.scanBarcode,
          label: 'Vin Check',
        ),
        const AppBottomNavigationItem(
          icon: LucideIcons.bookmark,
          label: 'Saved',
        ),
        AppBottomNavigationItem(
          icon: LucideIcons.userRound,
          label: 'Profile',
          onTap: onProfileTap,
        ),
      ],
    );
  }
}

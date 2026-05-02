import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_widgets.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBottomNavigation(
      height: height,
      items: const [
        AppBottomNavigationItem(
          icon: LucideIcons.house,
          label: 'Home',
          isSelected: true,
        ),
        AppBottomNavigationItem(icon: LucideIcons.search, label: 'Search'),
        AppBottomNavigationItem(
          icon: LucideIcons.scanBarcode,
          label: 'Vin Check',
        ),
        AppBottomNavigationItem(icon: LucideIcons.bookmark, label: 'Saved'),
        AppBottomNavigationItem(icon: LucideIcons.userRound, label: 'Profile'),
      ],
    );
  }
}

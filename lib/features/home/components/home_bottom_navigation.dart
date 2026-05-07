import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:motogo_app/design_system/app_widgets.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({
    super.key,
    required this.height,
    required this.activeIndex,
    required this.onTabSelected,
  });

  final double height;
  final int activeIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return AppBottomNavigation(
      height: height,
      items: [
        AppBottomNavigationItem(
          icon: activeIndex == 0 ? Boxicons.bxs_home : Boxicons.bx_home,
          label: 'Home',
          isSelected: activeIndex == 0,
          onTap: () => onTabSelected(0),
        ),
        AppBottomNavigationItem(
          icon: activeIndex == 1 ? Boxicons.bxs_search : Boxicons.bx_search,
          label: 'Search',
          isSelected: activeIndex == 1,
          onTap: () => onTabSelected(1),
        ),
        AppBottomNavigationItem(
          icon: activeIndex == 2
              ? Boxicons.bxs_barcode
              : Boxicons.bx_barcode_reader,
          label: 'Vin Check',
          isSelected: activeIndex == 2,
          onTap: () => onTabSelected(2),
        ),
        AppBottomNavigationItem(
          icon: activeIndex == 3 ? Boxicons.bxs_bookmark : Boxicons.bx_bookmark,
          label: 'Saved',
          isSelected: activeIndex == 3,
          onTap: () => onTabSelected(3),
        ),
        AppBottomNavigationItem(
          icon: activeIndex == 4 ? Boxicons.bxs_user : Boxicons.bx_user,
          label: 'Profile',
          isSelected: activeIndex == 4,
          onTap: () => onTabSelected(4),
        ),
      ],
    );
  }
}

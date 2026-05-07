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

  static const Set<int> _disabledTabIndexes = <int>{1, 2, 3};

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
          icon: Boxicons.bx_search,
          label: 'Search',
          isSelected: false,
          onTap: _disabledTabIndexes.contains(1)
              ? null
              : () => onTabSelected(1),
        ),
        AppBottomNavigationItem(
          icon: Boxicons.bx_barcode_reader,
          label: 'Vin Check',
          isSelected: false,
          onTap: _disabledTabIndexes.contains(2)
              ? null
              : () => onTabSelected(2),
        ),
        AppBottomNavigationItem(
          icon: Boxicons.bx_bookmark,
          label: 'Saved',
          isSelected: false,
          onTap: _disabledTabIndexes.contains(3)
              ? null
              : () => onTabSelected(3),
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

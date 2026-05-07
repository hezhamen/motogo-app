import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/home/components/home_bottom_navigation.dart';
import 'package:motogo_app/features/home/home_screen.dart';
import 'package:motogo_app/features/profile/profile_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _activeIndex = 0;
  int _previousIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  bool _isBottomNavVisible = true;

  // TODO(temporary): Search/VIN/Saved screens disabled. Keep tabs visible but inert.
  static const Set<int> _disabledTabIndexes = <int>{1, 2, 3};

  static const Duration _switchDuration = Duration(milliseconds: 280);
  static const Curve _switchCurve = Curves.easeOutCubic;
  static const Duration _bottomNavDuration = Duration(milliseconds: 220);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildActiveTab() {
    final List<Widget> tabs = <Widget>[
      HomeScreen(
        onBottomNavVisibilityChanged: (visible) {
          if (_activeIndex != 0) return;
          if (_isBottomNavVisible == visible) return;
          setState(() => _isBottomNavVisible = visible);
        },
      ),
      const _PlaceholderTab(title: 'Search'),
      const _PlaceholderTab(title: 'Vin Check'),
      const _PlaceholderTab(title: 'Saved'),
      const ProfileScreen(),
    ];

    return KeyedSubtree(
      key: ValueKey<int>(_activeIndex),
      child: PageStorage(
        bucket: _bucket,
        child: KeyedSubtree(
          key: PageStorageKey<String>('tab_$_activeIndex'),
          child: tabs[_activeIndex],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewPadding = MediaQuery.paddingOf(context);
    final double bottomNavHeight = viewPadding.bottom + 91;
    final bool slideFromRight = _activeIndex > _previousIndex;

    return Scaffold(
      backgroundColor: context.appBackground,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: _switchDuration,
                switchInCurve: _switchCurve,
                switchOutCurve: _switchCurve,
                layoutBuilder: (currentChild, previousChildren) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ...previousChildren,
                      currentChild ?? const SizedBox.shrink(),
                    ],
                  );
                },
                transitionBuilder: (child, animation) {
                  final bool isIncoming =
                      child.key == ValueKey<int>(_activeIndex);

                  final Offset inBegin = Offset(
                    slideFromRight ? 0.12 : -0.12,
                    0,
                  );
                  final Offset outEnd = Offset(
                    slideFromRight ? -0.12 : 0.12,
                    0,
                  );

                  final Animation<Offset> offset =
                      (isIncoming
                              ? Tween<Offset>(begin: inBegin, end: Offset.zero)
                              : Tween<Offset>(begin: Offset.zero, end: outEnd))
                          .animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: _switchCurve,
                            ),
                          );

                  return SlideTransition(position: offset, child: child);
                },
                child: _buildActiveTab(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IgnorePointer(
                  ignoring: !_isBottomNavVisible,
                  child: AnimatedSlide(
                    duration: _bottomNavDuration,
                    curve: Curves.easeOutCubic,
                    offset: _isBottomNavVisible
                        ? Offset.zero
                        : const Offset(0, 1),
                    child: HomeBottomNavigation(
                      height: bottomNavHeight,
                      activeIndex: _activeIndex,
                      onTabSelected: (index) {
                        if (_activeIndex == index) return;
                        if (_disabledTabIndexes.contains(index)) return;
                        setState(() {
                          _isBottomNavVisible = true;
                          _previousIndex = _activeIndex;
                          _activeIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.valueLarge.copyWith(
            color: context.appTextPrimary,
          ),
        ),
      ),
    );
  }
}

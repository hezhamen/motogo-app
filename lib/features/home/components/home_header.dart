import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/home/components/motogo_logo.dart';
import 'package:motogo_app/features/home/models/home_feed_layout.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
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
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: MediaQuery.paddingOf(context).top,
      ),
      decoration: BoxDecoration(color: context.appBackground),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MotogoLogo(),
              Row(
                children: [
                  _HeaderActionButton(
                    icon: Boxicons.bx_scan,
                    backgroundColor: context.appSurfaceRaised,
                    iconColor: context.appTextPrimary,
                    semanticLabel: 'Scan vehicle',
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _LayoutToggleButton(
                    value: feedLayout,
                    onChanged: onFeedLayoutChanged,
                  ),
                  const SizedBox(width: 8),
                  _HeaderActionButton(
                    icon: Boxicons.bx_plus,
                    backgroundColor: context.appAccent,
                    iconColor: Colors.white,
                    semanticLabel: 'Create listing',
                    onTap: onCreateListing,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LayoutToggleButton extends StatelessWidget {
  const _LayoutToggleButton({required this.value, required this.onChanged});

  final HomeFeedLayout value;
  final ValueChanged<HomeFeedLayout> onChanged;

  @override
  Widget build(BuildContext context) {
    final HomeFeedLayout nextValue = value == HomeFeedLayout.grid
        ? HomeFeedLayout.feed
        : HomeFeedLayout.grid;

    final IconData icon = value == HomeFeedLayout.grid
        ? Boxicons.bx_grid_alt
        : Boxicons.bx_list_ul;

    final String semanticLabel = value == HomeFeedLayout.grid
        ? 'Switch to feed view'
        : 'Switch to grid view';

    return Semantics(
      label: semanticLabel,
      button: true,
      child: SizedBox.square(
        dimension: 36,
        child: Material(
          color: context.appSurfaceRaised,
          shape: CircleBorder(
            side: BorderSide(color: context.appOutlineSubtle, width: 0.75),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => onChanged(nextValue),
            child: Icon(icon, size: 19, color: context.appTextPrimary),
          ),
        ),
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.semanticLabel,
    required this.onTap,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: SizedBox.square(
        dimension: 36,
        child: Material(
          color: backgroundColor,
          shape: CircleBorder(
            side: BorderSide(color: context.appOutlineSubtle, width: 0.75),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Icon(icon, color: iconColor, size: 17),
          ),
        ),
      ),
    );
  }
}

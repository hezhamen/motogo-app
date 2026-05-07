import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
                    icon: LucideIcons.plus,
                    backgroundColor: context.appAccent,
                    iconColor: Colors.white,
                    semanticLabel: 'Create listing',
                    onTap: onCreateListing,
                  ),
                  const SizedBox(width: 8),
                  _HeaderActionButton(
                    icon: LucideIcons.scanLine,
                    backgroundColor: context.appSurfaceRaised,
                    iconColor: context.appTextPrimary,
                    semanticLabel: 'Scan vehicle',
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _LayoutToggle(
                    value: feedLayout,
                    onChanged: onFeedLayoutChanged,
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

class _LayoutToggle extends StatelessWidget {
  const _LayoutToggle({required this.value, required this.onChanged});

  final HomeFeedLayout value;
  final ValueChanged<HomeFeedLayout> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: context.appSurfaceRaised,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.appOutlineSubtle, width: 0.75),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LayoutToggleButton(
            icon: Icons.grid_view_rounded,
            isSelected: value == HomeFeedLayout.grid,
            semanticLabel: 'Switch to grid view',
            onTap: () => onChanged(HomeFeedLayout.grid),
          ),
          _LayoutToggleButton(
            icon: Icons.view_agenda_rounded,
            isSelected: value == HomeFeedLayout.feed,
            semanticLabel: 'Switch to feed view',
            onTap: () => onChanged(HomeFeedLayout.feed),
          ),
        ],
      ),
    );
  }
}

class _LayoutToggleButton extends StatelessWidget {
  const _LayoutToggleButton({
    required this.icon,
    required this.isSelected,
    required this.semanticLabel,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isSelected
        ? context.appButtonPrimary
        : Colors.transparent;
    final Color iconColor = isSelected
        ? context.appButtonOnPrimary
        : context.appTextPrimary;

    return Semantics(
      label: semanticLabel,
      selected: isSelected,
      button: true,
      child: SizedBox(
        width: 34,
        height: 32,
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Icon(icon, size: 19, color: iconColor),
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

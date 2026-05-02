import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/home/components/motogo_logo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: MediaQuery.paddingOf(context).top,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 32,
            offset: Offset(0, 2),
          ),
        ],
      ),
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
                    backgroundColor: AppColors.accent,
                    iconColor: Colors.white,
                    semanticLabel: 'Create listing',
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _HeaderActionButton(
                    icon: LucideIcons.scanLine,
                    backgroundColor: AppColors.surfaceRaised,
                    iconColor: AppColors.textPrimary,
                    semanticLabel: 'Scan vehicle',
                    onTap: () {},
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
          shape: const CircleBorder(
            side: BorderSide(color: AppColors.outlineSubtle, width: 0.75),
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

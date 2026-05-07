import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

class PostCarTitleBlock extends StatelessWidget {
  const PostCarTitleBlock({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.sectionTitle.copyWith(
            color: context.appTextPrimary,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          description,
          style: AppTextStyles.bodyMuted.copyWith(
            color: context.appTextSecondary,
          ),
        ),
      ],
    );
  }
}

class PostCarHelperRow extends StatelessWidget {
  const PostCarHelperRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: context.appTextPrimary),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class PostCarChoiceCheckCard extends StatelessWidget {
  const PostCarChoiceCheckCard({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: AppSurface(
          height: 61,
          width: double.infinity,
          color: context.appSurface,
          borderRadius: AppRadius.card,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.value.copyWith(
                    color: context.appTextPrimary,
                  ),
                ),
              ),
              SizedBox(
                width: 22,
                height: 22,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      LucideIcons.circle,
                      size: 22,
                      color: context.appTextPrimary,
                    ),
                    if (selected)
                      Icon(
                        LucideIcons.check,
                        size: 14,
                        color: context.appTextPrimary,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

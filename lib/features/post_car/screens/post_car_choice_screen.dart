import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';

class PostCarChoiceScreen extends StatelessWidget {
  const PostCarChoiceScreen({
    super.key,
    required this.onEnterVinCode,
    required this.onEnterCarManually,
  });

  final VoidCallback onEnterVinCode;
  final VoidCallback onEnterCarManually;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostCarTitleBlock(
            title: 'How would you like to add the car?',
            description:
                'Scan the VIN to fill details automatically, or continue with manual entry.',
          ),
          const SizedBox(height: 36),
          _ChoiceCard(
            icon: Boxicons.bx_barcode_reader,
            title: 'Scan VIN code',
            description:
                'Use the vehicle identification number to fetch the car details faster.',
            onTap: onEnterVinCode,
          ),
          const SizedBox(height: 14),
          _ChoiceCard(
            icon: Boxicons.bx_edit,
            title: 'Enter details manually',
            description:
                'Type the vehicle information yourself if the VIN is unavailable.',
            onTap: onEnterCarManually,
          ),
        ],
      ),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: AppSurface(
          height: 94,
          width: double.infinity,
          color: context.appSurfaceRaised,
          borderRadius: AppRadius.card,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: context.appSurface,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 22, color: context.appTextPrimary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: context.appTextPrimary,
                        letterSpacing: -0.42,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: AppTextStyles.caption.copyWith(
                        color: context.appTextSecondary,
                      ),
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

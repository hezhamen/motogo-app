import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/home/models/home_data.dart';

class BrandBadge extends StatelessWidget {
  const BrandBadge({super.key, required this.brand});

  final HomeBrand brand;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: brand.name,
      button: true,
      child: SizedBox(
        width: 54,
        child: Column(
          children: [
            AppSurface(
              width: 54,
              height: 54,
              alignment: Alignment.center,
              color: AppColors.surfaceRaised,
              borderRadius: 27,
              borderColor: AppColors.outlineSubtle,
              child: Image.network(
                brand.logoUrl,
                width: brand.logoSize.width,
                height: brand.logoSize.height,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink();
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              brand.name,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}

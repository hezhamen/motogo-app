import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/home/models/home_data.dart';

class BrandBadge extends StatelessWidget {
  const BrandBadge({super.key, required this.brand, this.collapseT = 0});

  final HomeBrand brand;

  /// 0 = expanded (show label), 1 = collapsed (hide label).
  final double collapseT;

  @override
  Widget build(BuildContext context) {
    final double t = collapseT.clamp(0, 1);
    final double badgeSize = ui.lerpDouble(54, 44, t)!;
    final double logoSize = ui.lerpDouble(28, 22, t)!;
    final double labelGap = ui.lerpDouble(8, 6, t)!;
    final double labelHeight = ui.lerpDouble(16, 6, t)!;
    final double labelOpacity = (1 - t).clamp(0, 1);

    final Widget logo = brand.isNetworkLogo
        ? Image.network(
            brand.logoUrl,
            width: logoSize,
            height: logoSize,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          )
        : Image.asset(
            brand.logoUrl,
            width: logoSize,
            height: logoSize,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          );

    return Semantics(
      label: brand.name,
      button: true,
      child: SizedBox(
        width: badgeSize,
        child: Column(
          children: [
            AppSurface(
              width: badgeSize,
              height: badgeSize,
              alignment: Alignment.center,
              color: context.appSurfaceRaised,
              borderRadius: badgeSize / 2,
              borderColor: context.appOutlineSubtle,
              child: logo,
            ),
            Padding(
              padding: EdgeInsets.only(top: labelGap),
              child: SizedBox(
                height: labelHeight,
                child: Opacity(
                  opacity: labelOpacity,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      brand.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.appTextSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

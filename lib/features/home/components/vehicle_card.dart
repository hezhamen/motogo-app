import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/home/models/home_data.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    this.width = 194,
    this.height = 202,
    this.borderRadius = AppRadius.card,
    this.backgroundColor,
  });

  final HomeVehicle vehicle;
  final double width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    const double footerHeight = 38;
    final double imageHeight = (height - footerHeight).clamp(0, height);

    return Semantics(
      label: '${vehicle.name}, ${vehicle.price}',
      button: true,
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                SizedBox(
                  height: imageHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        vehicle.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return ColoredBox(color: context.appSurfaceRaised);
                        },
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x00000000), Color(0xB3000000)],
                            stops: [0.72, 1],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 7,
                        child: Image.asset(
                          vehicle.brandLogoUrl,
                          width: vehicle.brandLogoSize.width,
                          height: vehicle.brandLogoSize.height,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      const Positioned(
                        right: 9,
                        bottom: 8,
                        child: Row(
                          children: [
                            _VehiclePill('2025'),
                            SizedBox(width: 4),
                            _VehiclePill('XLT'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            vehicle.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.value.copyWith(
                              color: context.appTextPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          vehicle.price,
                          style: AppTextStyles.value.copyWith(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VehiclePill extends StatelessWidget {
  const _VehiclePill(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      alignment: Alignment.center,
      color: context.appSurfaceRaised,
      borderRadius: 24,
      borderColor: context.appOutlineSubtle,
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: context.appTextPrimary,
          fontSize: 8.4,
          letterSpacing: -0.25,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

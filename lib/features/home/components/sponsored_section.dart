import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/home/components/home_section_title.dart';
import 'package:motogo_app/features/home/components/vehicle_card.dart';
import 'package:motogo_app/features/home/models/home_data.dart';

class SponsoredSection extends StatelessWidget {
  const SponsoredSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.only(top: 18, bottom: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: HomeSectionTitle('Sponsored'),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 202,
              child: ListView.separated(
                clipBehavior: Clip.none,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                scrollDirection: Axis.horizontal,
                itemCount: HomeData.featuredVehicles.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return VehicleCard(vehicle: HomeData.featuredVehicles[index]);
                },
              ),
            ),
            const SizedBox(height: 12),
            const Center(child: _CarouselDots()),
            const SizedBox(height: 38),
            LayoutBuilder(
              builder: (context, constraints) {
                const double horizontalPadding = AppSpacing.md;
                const double columnGap = 10;
                final double cardWidth =
                    (constraints.maxWidth - horizontalPadding * 2 - columnGap) /
                    2;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  child: Wrap(
                    spacing: columnGap,
                    runSpacing: 12,
                    children: [
                      for (final vehicle in HomeData.feedVehicles)
                        VehicleCard(width: cardWidth, vehicle: vehicle),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselDots extends StatelessWidget {
  const _CarouselDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final bool isActive = index == 0;
        return Container(
          width: isActive ? 8 : 5,
          height: isActive ? 8 : 5,
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          decoration: BoxDecoration(
            color: isActive ? AppColors.accent : AppColors.textTertiary,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

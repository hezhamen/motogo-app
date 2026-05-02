import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/home/components/brand_badge.dart';
import 'package:motogo_app/features/home/components/home_section_title.dart';
import 'package:motogo_app/features/home/models/home_data.dart';

class PopularBrandsSection extends StatelessWidget {
  const PopularBrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeSectionTitle('Popular Brands'),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 82,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: HomeData.popularBrands.length,
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                return BrandBadge(brand: HomeData.popularBrands[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

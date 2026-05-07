import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/features/home/components/brand_badge.dart';
import 'package:motogo_app/features/home/components/home_section_title.dart';
import 'package:motogo_app/features/home/models/home_data.dart';
import 'package:motogo_app/features/vehicle_catalog/vehicle_catalog_repository.dart';

class PopularBrandsSection extends StatefulWidget {
  const PopularBrandsSection({super.key});

  @override
  State<PopularBrandsSection> createState() => _PopularBrandsSectionState();
}

class _PopularBrandsSectionState extends State<PopularBrandsSection> {
  late final Future<List<HomeBrand>> _popularBrandsFuture;

  @override
  void initState() {
    super.initState();
    _popularBrandsFuture = _loadPopularBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          FutureBuilder<List<HomeBrand>>(
            future: _popularBrandsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                log(
                  'Popular brands load failed',
                  error: snapshot.error,
                  stackTrace: snapshot.stackTrace,
                );
              }
              final brands = snapshot.hasData && snapshot.data!.isNotEmpty
                  ? snapshot.data!
                  : HomeData.popularBrands;
              return SizedBox(
                height: 82,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: brands.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return BrandBadge(brand: brands[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<List<HomeBrand>> _loadPopularBrands() async {
    final popular = await VehicleCatalogRepository.instance.popularMakes(
      limit: 12,
    );
    log('Popular brands from DB: ${popular.length}');
    return popular
        .where((m) => m.makeEn.isNotEmpty && m.makeLogo.isNotEmpty)
        .map(
          (m) => HomeBrand.network(
            name: m.makeEn,
            logoUrl: m.makeLogo,
            logoSize: const Size(28, 28),
          ),
        )
        .toList(growable: false);
  }
}

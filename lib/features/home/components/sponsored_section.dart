import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/home/components/home_section_title.dart';
import 'package:motogo_app/features/home/components/vehicle_card.dart';
import 'package:motogo_app/features/home/models/home_data.dart';
import 'package:motogo_app/features/home/models/home_feed_layout.dart';
import 'package:motogo_app/features/vehicle_details/vehicle_detail_screen.dart';

class SponsoredSection extends StatefulWidget {
  const SponsoredSection({super.key, required this.layout});

  final HomeFeedLayout layout;

  @override
  State<SponsoredSection> createState() => _SponsoredSectionState();
}

class _SponsoredSectionState extends State<SponsoredSection> {
  @override
  Widget build(BuildContext context) {
    final double bottomPadding = widget.layout == HomeFeedLayout.grid
        ? AppSpacing.sm
        : AppSpacing.md;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ColoredBox(
          color: context.appSurface,
          child: Padding(
            padding: EdgeInsets.only(top: 18, bottom: bottomPadding),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: HomeData.featuredVehicles.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final vehicle = HomeData.featuredVehicles[index];
                      final String heroTag = 'featured_${index}_image';
                      final String logoHeroTag = 'featured_${index}_logo';
                      return VehicleCard(
                        vehicle: vehicle,
                        borderRadius: 0,
                        backgroundColor: Colors.transparent,
                        heroTag: heroTag,
                        logoHeroTag: logoHeroTag,
                        onTap: () => VehicleDetailScreen.open(
                          context,
                          vehicle: vehicle,
                          heroTag: heroTag,
                          logoHeroTag: logoHeroTag,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.layout == HomeFeedLayout.grid)
          const _GridFeedVehicles()
        else
          _ListFeedVehicles(),
      ],
    );
  }
}

class _GridFeedVehicles extends StatelessWidget {
  const _GridFeedVehicles();

  @override
  Widget build(BuildContext context) {
    const double padding = AppSpacing.md;
    const double gap = 10;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double tileWidth = (constraints.maxWidth - gap) / 2;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: AppSpacing.md),
            itemCount: HomeData.feedVehicles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: gap,
              mainAxisSpacing: gap,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final vehicle = HomeData.feedVehicles[index];
              final String heroTag = 'grid_${index}_image';
              final String logoHeroTag = 'grid_${index}_logo';
              return VehicleCard(
                vehicle: vehicle,
                width: tileWidth,
                height: tileWidth,
                borderRadius: 0,
                heroTag: heroTag,
                logoHeroTag: logoHeroTag,
                onTap: () => VehicleDetailScreen.open(
                  context,
                  vehicle: vehicle,
                  heroTag: heroTag,
                  logoHeroTag: logoHeroTag,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ListFeedVehicles extends StatelessWidget {
  const _ListFeedVehicles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < HomeData.feedVehicles.length; index++) ...[
          _FeedVehicleCard(vehicle: HomeData.feedVehicles[index]),
          if (index != HomeData.feedVehicles.length - 1)
            const SizedBox(height: 20),
        ],
      ],
    );
  }
}

class _FeedVehicleCard extends StatefulWidget {
  const _FeedVehicleCard({required this.vehicle});

  final HomeVehicle vehicle;

  @override
  State<_FeedVehicleCard> createState() => _FeedVehicleCardState();
}

class _FeedVehicleCardState extends State<_FeedVehicleCard> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${widget.vehicle.name}, ${widget.vehicle.price}',
      button: true,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: [
                    _VehicleAvatar(vehicle: widget.vehicle),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.vehicle.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.valueLarge.copyWith(
                              color: context.appTextPrimary,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${widget.vehicle.price} • Sponsored',
                            style: AppTextStyles.caption.copyWith(
                              color: context.appTextTertiary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.more_horiz_rounded,
                      size: 20,
                      color: context.appTextPrimary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      clipBehavior: Clip.none,
                      itemCount: 3,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(
                          widget.vehicle.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return ColoredBox(color: context.appSurfaceRaised);
                          },
                        );
                      },
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0x99000000)],
                          stops: [0.72, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      bottom: 14,
                      child: Row(
                        children: [
                          _VehiclePill('2025'),
                          const SizedBox(width: 6),
                          _VehiclePill('XLT'),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 14,
                      child: Image.asset(
                        widget.vehicle.brandLogoUrl,
                        width: widget.vehicle.brandLogoSize.width,
                        height: widget.vehicle.brandLogoSize.height,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 12,
                      child: Center(
                        child: _CarouselDots(activeIndex: _pageIndex),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.vehicle.price} - ${widget.vehicle.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.value.copyWith(
                          color: context.appTextPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'View details',
                      style: AppTextStyles.caption.copyWith(
                        color: context.appTextTertiary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
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

class _VehicleAvatar extends StatelessWidget {
  const _VehicleAvatar({required this.vehicle});

  final HomeVehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: context.appSurfaceRaised,
        shape: BoxShape.circle,
        border: Border.all(color: context.appOutlineSubtle),
      ),
      alignment: Alignment.center,
      child: Image.asset(
        vehicle.brandLogoUrl,
        width: vehicle.brandLogoSize.width * 0.85,
        height: vehicle.brandLogoSize.height * 0.85,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.directions_car_rounded,
            size: 18,
            color: context.appTextPrimary,
          );
        },
      ),
    );
  }
}

class _CarouselDots extends StatelessWidget {
  const _CarouselDots({required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final bool isActive = index == activeIndex;
        return Container(
          width: isActive ? 8 : 5,
          height: isActive ? 8 : 5,
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          decoration: BoxDecoration(
            color: isActive ? context.appAccent : context.appTextTertiary,
            shape: BoxShape.circle,
          ),
        );
      }),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

class ReviewPostScreen extends StatelessWidget {
  const ReviewPostScreen({
    super.key,
    required this.title,
    required this.location,
    required this.timeLabel,
    this.coverImagePath,
    this.makeLogoUrl,
  });

  final String title;
  final String location;
  final String timeLabel;
  final String? coverImagePath;
  final String? makeLogoUrl;

  static const String fallbackHeroAsset =
      'assets/figma/post_car/review/hero.png';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroHeader(coverImagePath: coverImagePath, makeLogoUrl: makeLogoUrl),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _MetaChip(
                      icon: Boxicons.bx_map,
                      text: location,
                      alignEnd: false,
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: AppTextStyles.sectionTitle.copyWith(
                        color: context.appTextPrimary,
                      ),
                    ),
                    const Spacer(),
                    _MetaChip(
                      icon: Boxicons.bx_time,
                      text: timeLabel,
                      alignEnd: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const _DividerLine(),
                const SizedBox(height: 24),
                const _SpecGrid(),
                const SizedBox(height: 36),
                Text(
                  'Detailed Informations',
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: context.appTextPrimary,
                  ),
                ),
                const SizedBox(height: 14),
                const _InfoRow(
                  label: 'Body Color',
                  value: 'Khanaii',
                  leadingDotColor: Color(0xFFB6C0A7),
                ),
                const _DividerLine(),
                const _InfoRow(
                  label: 'Interior Color',
                  value: 'Black',
                  leadingDotColor: Color(0xFF222222),
                ),
                const _DividerLine(),
                const _InfoRow(label: 'Seat No', value: '5 Seats'),
                const _DividerLine(),
                const _InfoRow(label: 'Seat Material', value: 'Leather'),
                const _DividerLine(),
                const _InfoRow(label: 'State', value: 'Used'),
                const _DividerLine(),
                const SizedBox(height: 24),
                Text(
                  'Car Paints',
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: context.appTextPrimary,
                  ),
                ),
                const SizedBox(height: 14),
                const _InfoRow(
                  label: 'Body Color',
                  value: 'Khanaii',
                  leadingDotColor: Color(0xFFB6C0A7),
                ),
                const _DividerLine(),
                const _InfoRow(
                  label: 'Interior Color',
                  value: 'Black',
                  leadingDotColor: Color(0xFF222222),
                ),
                const _DividerLine(),
                const _InfoRow(label: 'Seat No', value: '5 Seats'),
                const _DividerLine(),
                const _InfoRow(label: 'Seat Material', value: 'Leather'),
                const _DividerLine(),
                const _InfoRow(label: 'State', value: 'Used'),
                const _DividerLine(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.coverImagePath, required this.makeLogoUrl});

  final String? coverImagePath;
  final String? makeLogoUrl;

  @override
  Widget build(BuildContext context) {
    final String? cover = coverImagePath;
    final String? logoUrl = makeLogoUrl;

    return SizedBox(
      height: 242,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: cover == null || cover.isEmpty
                ? Image.asset(
                    ReviewPostScreen.fallbackHeroAsset,
                    fit: BoxFit.cover,
                  )
                : Image.file(File(cover), fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.12),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                  ],
                  stops: const [0, 0.82, 1],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 25,
                  child: Center(
                    child: _DotsIndicator(activeIndex: 1, count: 4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -32,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: const Color(0xFFE2E2E2),
                    width: 1.333,
                  ),
                ),
                alignment: Alignment.center,
                child: logoUrl == null || logoUrl.isEmpty
                    ? Icon(
                        Boxicons.bx_car,
                        size: 22,
                        color: context.appTextPrimary.withValues(alpha: 0.7),
                      )
                    : Image.network(
                        logoUrl,
                        width: 38.233,
                        height: 32,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Boxicons.bx_car,
                            size: 22,
                            color: context.appTextPrimary.withValues(
                              alpha: 0.7,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({required this.activeIndex, required this.count});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final bool active = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : 6),
          width: active ? 14 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: active ? 0.95 : 0.6),
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.text,
    required this.alignEnd,
  });

  final IconData icon;
  final String text;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final Color color = context.appTextPrimary.withValues(alpha: 0.8);
    return SizedBox(
      width: 110,
      child: Row(
        mainAxisAlignment: alignEnd
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: context.appTextTertiary);
  }
}

class _SpecGrid extends StatelessWidget {
  const _SpecGrid();

  @override
  Widget build(BuildContext context) {
    const specs = [
      _SpecCardData(label: 'Piston', value: '4', icon: Boxicons.bx_circle),
      _SpecCardData(label: 'Gearbox', value: 'Auto', icon: Boxicons.bx_cog),
      _SpecCardData(
        label: 'Engine Size',
        value: '2.5',
        icon: Boxicons.bx_tachometer,
      ),
      _SpecCardData(
        label: 'Milage',
        value: '73,000 KM',
        icon: Boxicons.bx_line_chart,
      ),
      _SpecCardData(label: 'Region', value: 'USA', icon: Boxicons.bx_globe),
      _SpecCardData(label: 'Petrol', value: 'Gas', icon: Boxicons.bx_gas_pump),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const double gap = 14;
        final double width = (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [for (final s in specs) _SpecCard(data: s, width: width)],
        );
      },
    );
  }
}

class _SpecCardData {
  const _SpecCardData({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String value;
  final IconData icon;
}

class _SpecCard extends StatelessWidget {
  const _SpecCard({required this.data, required this.width});
  final _SpecCardData data;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      width: width,
      color: context.appSurface,
      borderRadius: 16,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: context.appSurfaceRaised,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              data.icon,
              size: 24,
              color: context.appTextPrimary.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.label,
            style: AppTextStyles.caption.copyWith(
              color: context.appTextSecondary,
              fontSize: 10,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            data.value,
            style: AppTextStyles.value.copyWith(color: context.appTextPrimary),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.leadingDotColor,
  });

  final String label;
  final String value;
  final Color? leadingDotColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyles.value.copyWith(
              color: context.appTextSecondary,
              fontSize: 14,
              letterSpacing: -0.42,
            ),
          ),
          const Spacer(),
          if (leadingDotColor != null) ...[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: leadingDotColor!,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            value,
            style: AppTextStyles.value.copyWith(
              color: context.appTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.42,
            ),
          ),
        ],
      ),
    );
  }
}

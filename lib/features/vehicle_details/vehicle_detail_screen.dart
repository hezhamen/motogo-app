import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/home/models/home_data.dart';

/// Vehicle posting details screen (Figma node `34:497`).
class VehicleDetailScreen extends StatefulWidget {
  const VehicleDetailScreen({
    super.key,
    required this.vehicle,
    required this.heroTag,
    required this.logoHeroTag,
  });

  final HomeVehicle vehicle;
  final String heroTag;
  final String logoHeroTag;

  static Future<void> open(
    BuildContext context, {
    required HomeVehicle vehicle,
    required String heroTag,
    required String logoHeroTag,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => VehicleDetailScreen(
          vehicle: vehicle,
          heroTag: heroTag,
          logoHeroTag: logoHeroTag,
        ),
      ),
    );
  }

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _enterController;
  bool _logoIsLight = false;

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _initLogoTone();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final media = MediaQuery.maybeOf(context);
      final bool reduceMotion =
          (media?.disableAnimations ?? false) ||
          (media?.accessibleNavigation ?? false);
      if (reduceMotion) {
        _enterController.value = 1;
      } else {
        _enterController.forward();
      }
    });
  }

  Future<void> _initLogoTone() async {
    final bool isLight = await _isAssetMostlyLight(widget.vehicle.brandLogoUrl);
    if (!mounted) return;
    setState(() => _logoIsLight = isLight);
  }

  Future<bool> _isAssetMostlyLight(String assetPath) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(
        data.buffer.asUint8List(),
      );
      final ui.ImageDescriptor descriptor = await ui.ImageDescriptor.encoded(
        buffer,
      );
      final ui.Codec codec = await descriptor.instantiateCodec(
        targetWidth: 24,
        targetHeight: 24,
      );
      final ui.FrameInfo frame = await codec.getNextFrame();
      final ByteData? rgba = await frame.image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );
      if (rgba == null) return false;

      final Uint8List bytes = rgba.buffer.asUint8List();
      int bright = 0;
      int opaque = 0;

      for (int i = 0; i < bytes.length; i += 4) {
        final int r = bytes[i];
        final int g = bytes[i + 1];
        final int b = bytes[i + 2];
        final int a = bytes[i + 3];
        if (a < 20) continue;
        opaque++;
        final double luma = 0.2126 * r + 0.7152 * g + 0.0722 * b;
        if (luma > 200) bright++;
      }

      if (opaque == 0) return false;
      return bright / opaque > 0.55;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _enterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewPadding = MediaQuery.paddingOf(context);
    final double headerHeight = viewPadding.top + 71;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: headerHeight),
                _HeroHeader(
                  vehicle: widget.vehicle,
                  heroTag: widget.heroTag,
                  logoHeroTag: widget.logoHeroTag,
                  logoIsLight: _logoIsLight,
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _StaggerFadeSlide(
                        controller: _enterController,
                        begin: 0.00,
                        end: 0.35,
                        child: Row(
                          children: [
                            const _MetaChip(
                              icon: Boxicons.bx_map,
                              text: 'Sulaymaniyah',
                              alignEnd: false,
                            ),
                            const Spacer(),
                            Text(
                              '${widget.vehicle.name} 2021',
                              style: AppTextStyles.valueLarge.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            const _MetaChip(
                              icon: Boxicons.bx_time,
                              text: '2 Days Ago',
                              alignEnd: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const _DividerLine(),
                      const SizedBox(height: 24),
                      _StaggerFadeSlide(
                        controller: _enterController,
                        begin: 0.15,
                        end: 0.65,
                        offsetY: 10,
                        child: _SpecGrid(controller: _enterController),
                      ),
                      const SizedBox(height: 36),
                      _StaggerFadeSlide(
                        controller: _enterController,
                        begin: 0.35,
                        end: 1.00,
                        offsetY: 12,
                        child: const _DetailSections(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _DetailHeader(
            height: headerHeight,
            onBack: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }
}

class _StaggerFadeSlide extends StatelessWidget {
  const _StaggerFadeSlide({
    required this.controller,
    required this.begin,
    required this.end,
    required this.child,
    this.offsetY = 8,
  });

  final AnimationController controller;
  final double begin;
  final double end;
  final double offsetY;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final CurvedAnimation curved = CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, offsetY / 100),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}

class _DetailSections extends StatelessWidget {
  const _DetailSections();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Informations',
          style: AppTextStyles.valueLarge.copyWith(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 14),
        const _InfoRow(
          label: 'Body Color',
          value: 'Khanaii',
          leadingDotColor: Color(0xFFB5524D),
        ),
        const _DividerLine(),
        const _InfoRow(
          label: 'Interior Color',
          value: 'Black',
          leadingDotColor: Color(0xFF000000),
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
          style: AppTextStyles.valueLarge.copyWith(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 14),
        const _InfoRow(
          label: 'Body Color',
          value: 'Khanaii',
          leadingDotColor: Color(0xFFB5524D),
        ),
        const _DividerLine(),
        const _InfoRow(
          label: 'Interior Color',
          value: 'Black',
          leadingDotColor: Color(0xFF000000),
        ),
        const _DividerLine(),
        const _InfoRow(label: 'Seat No', value: '5 Seats'),
        const _DividerLine(),
        const _InfoRow(label: 'Seat Material', value: 'Leather'),
        const _DividerLine(),
        const _InfoRow(label: 'State', value: 'Used'),
        const _DividerLine(),
      ],
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.height, required this.onBack});

  final double height;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: MediaQuery.paddingOf(context).top,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          height: 44,
          child: _HeaderCircleButton(
            semanticLabel: 'Back',
            icon: Boxicons.bx_arrow_back,
            onTap: onBack,
          ),
        ),
      ),
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  const _HeaderCircleButton({
    required this.semanticLabel,
    required this.icon,
    required this.onTap,
  });

  final String semanticLabel;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: SizedBox.square(
        dimension: 36,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Icon(icon, color: Colors.black, size: 22),
          ),
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.vehicle,
    required this.heroTag,
    required this.logoHeroTag,
    required this.logoIsLight,
  });

  final HomeVehicle vehicle;
  final String heroTag;
  final String logoHeroTag;
  final bool logoIsLight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 242,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Hero(
              tag: heroTag,
              child: Image.asset(
                vehicle.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const ColoredBox(color: Color(0xFFF5F5F5));
                },
              ),
            ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 25,
                child: Center(child: _DotsIndicator(activeIndex: 1, count: 4)),
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
                  color: logoIsLight
                      ? const Color(0xFF1C1C1E)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: logoIsLight
                        ? const Color(0x33000000)
                        : const Color(0xFFE2E2E2),
                    width: 1.333,
                  ),
                ),
                alignment: Alignment.center,
                child: Hero(
                  tag: logoHeroTag,
                  child: Image.asset(
                    vehicle.brandLogoUrl,
                    width: 38.233,
                    height: 32,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Boxicons.bx_car,
                        size: 22,
                        color: logoIsLight
                            ? Colors.white.withValues(alpha: 0.7)
                            : Colors.black.withValues(alpha: 0.7),
                      );
                    },
                  ),
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
    const Color color = Color(0xCC000000);
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
            style: AppTextStyles.caption.copyWith(
              color: color,
              fontSize: 12,
              letterSpacing: -0.36,
              fontWeight: FontWeight.w500,
            ),
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
    return Container(height: 1, color: const Color(0x1A000000));
  }
}

class _SpecGrid extends StatelessWidget {
  const _SpecGrid({required this.controller});

  final AnimationController controller;

  static const specs = [
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double gap = 19;
        final double width = (constraints.maxWidth - gap * 2) / 3;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (int i = 0; i < specs.length; i++)
              _StaggerFadeSlide(
                controller: controller,
                begin: 0.18 + i * 0.06,
                end: 0.70 + i * 0.04,
                offsetY: 10,
                child: _SpecCard(data: specs[i], width: width),
              ),
          ],
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
      color: const Color(0xFFF5F5F5),
      borderRadius: 16,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFE6E6E6),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(data.icon, size: 24, color: const Color(0x99000000)),
          ),
          const SizedBox(height: 16),
          Text(
            data.label,
            style: AppTextStyles.caption.copyWith(
              color: const Color(0x99000000),
              fontSize: 10,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            data.value,
            style: AppTextStyles.value.copyWith(
              color: Colors.black,
              fontSize: 14,
              letterSpacing: -0.42,
            ),
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
              color: const Color(0x99000000),
              fontSize: 14,
              letterSpacing: -0.42,
              fontWeight: FontWeight.w500,
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
              color: Colors.black,
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

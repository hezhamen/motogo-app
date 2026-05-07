import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';

const String _vinHeroImageAsset = 'assets/figma/post_car/vin_hero.png';

class VinCodeScreen extends StatelessWidget {
  const VinCodeScreen({super.key, required this.onContinueChanged});

  static const String _vinCode = '4Y1SL65848Z411439';
  final ValueChanged<bool> onContinueChanged;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onContinueChanged(true);
    });
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostCarTitleBlock(
            title: 'VIN code verification',
            description:
                'Review the VIN and scan it if you want to re-read the code from the car.',
          ),
          const SizedBox(height: 36),
          const _VinIllustration(),
          const SizedBox(height: 36),
          const _FieldLabel('VIN code'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _FieldSurface(
                  child: const Text(_vinCode, style: _valueStyle),
                ),
              ),
              const SizedBox(width: 10),
              const _IconButtonSurface(
                icon: LucideIcons.scanLine,
                semanticLabel: 'Scan the VIN code again',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const PostCarHelperRow(
            icon: LucideIcons.info,
            text:
                'We use the VIN to confirm the vehicle and prefill the details on the next screen.',
          ),
        ],
      ),
    );
  }
}

class _VinIllustration extends StatelessWidget {
  const _VinIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 261,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _vinHeroImageAsset,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: context.appSurface);
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: 234,
                  height: 99,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.appSurfaceRaised,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 8),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'You Car VIN is here.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.label.copyWith(
                                color: context.appTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 174,
                              child: Text(
                                'This is the vehicle identification number (VIN) of your car. It is a unique code that identifies your car and is used to track its history and ownership.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.caption.copyWith(
                                  color: context.appTextSecondary,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '4Y1SL65848Z411439',
                              style: AppTextStyles.valueLarge.copyWith(
                                color: context.appTextSecondary,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.19,
                              ),
                            ),
                          ],
                        ),
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.label.copyWith(color: context.appTextSecondary),
    );
  }
}

class _FieldSurface extends StatelessWidget {
  const _FieldSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      height: 61,
      width: double.infinity,
      color: context.appSurfaceRaised,
      borderRadius: AppRadius.card,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Align(alignment: Alignment.centerLeft, child: child),
    );
  }
}

class _IconButtonSurface extends StatelessWidget {
  const _IconButtonSurface({required this.icon, required this.semanticLabel});

  final IconData icon;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.card),
          onTap: () {},
          child: AppSurface(
            width: 61,
            height: 61,
            color: context.appSurfaceRaised,
            borderRadius: AppRadius.card,
            alignment: Alignment.center,
            child: Icon(icon, size: 22, color: context.appTextPrimary),
          ),
        ),
      ),
    );
  }
}

const TextStyle _valueStyle = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
  fontSize: 14,
  color: Colors.black,
  letterSpacing: -0.42,
);

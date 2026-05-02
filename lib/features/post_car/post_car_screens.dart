import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

const Color _whiteChipColor = Color(0xFFF7F7F7);
const Color _blackChipColor = Color(0xFF0D0D0D);
const Color _redChipColor = Color(0xFFFF1A1A);
const Color _navyChipColor = Color(0xFF081D8D);
const Color _greyChipColor = Color(0xFF8E8E8E);

const String _vinHeroImageAsset =
    'https://www.figma.com/api/mcp/asset/de93ff5f-17d3-4b34-be3b-1c0ea06e8486';
const String _nissanLogoAsset =
    'https://www.figma.com/api/mcp/asset/50803d93-dbb4-45f4-93ae-2bf6671b981d';

class PostCarChoiceScreen extends StatelessWidget {
  const PostCarChoiceScreen({
    super.key,
    required this.onEnterVinCode,
    required this.onEnterCarManually,
  });

  final VoidCallback onEnterVinCode;
  final VoidCallback onEnterCarManually;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleBlock(
            title: 'How would you like to add the car?',
            description:
                'Scan the VIN to fill details automatically, or continue with manual entry.',
          ),
          const SizedBox(height: 36),
          _ChoiceCard(
            icon: LucideIcons.scanBarcode,
            title: 'Scan VIN code',
            description:
                'Use the vehicle identification number to fetch the car details faster.',
            onTap: onEnterVinCode,
          ),
          const SizedBox(height: 14),
          _ChoiceCard(
            icon: LucideIcons.pencilLine,
            title: 'Enter details manually',
            description:
                'Type the vehicle information yourself if the VIN is unavailable.',
            onTap: onEnterCarManually,
          ),
        ],
      ),
    );
  }
}

class VinCodeScreen extends StatelessWidget {
  const VinCodeScreen({super.key});

  static const String _vinCode = '4Y1SL65848Z411439';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleBlock(
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
          const _HelperRow(
            icon: LucideIcons.info,
            text:
                'We use the VIN to confirm the vehicle and prefill the details on the next screen.',
          ),
        ],
      ),
    );
  }
}

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  static const List<String> _trimOptions = <String>[
    'S',
    'SV',
    'SR',
    'SL',
    'Platinum',
    'SR+',
    'SV+',
    'GCC',
  ];

  static const List<_ColorOption> _colorOptions = <_ColorOption>[
    _ColorOption(id: 'white', label: 'White', color: _whiteChipColor),
    _ColorOption(id: 'black', label: 'Black', color: _blackChipColor),
    _ColorOption(id: 'red', label: 'Red', color: _redChipColor),
    _ColorOption(id: 'navy', label: 'Navy', color: _navyChipColor),
    _ColorOption(id: 'grey-1', label: 'Grey', color: _greyChipColor),
    _ColorOption(id: 'grey-2', label: 'Grey', color: _greyChipColor),
  ];

  static const List<String> _transmissionOptions = <String>[
    'Automatic',
    'Manual',
  ];
  static const List<String> _cylinderOptions = <String>[
    '3',
    '4',
    '6',
    '8',
    '12',
  ];

  String _selectedTrim = 'SV';
  String _selectedColor = 'black';
  String _selectedTransmission = 'Automatic';
  String _selectedCylinder = '4';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleBlock(
            title: 'Confirm the vehicle details',
            description:
                'Double-check the information before you continue to the final listing setup.',
          ),
          const SizedBox(height: 36),
          _LabeledField(
            label: 'Make',
            child: _DropdownField(
              child: Row(
                children: [
                  Image.network(
                    _nissanLogoAsset,
                    width: 24,
                    height: 20,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(width: 24, height: 20);
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text('Nissan', style: _valueStyle),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Model',
            child: _DropdownField(
              child: Row(
                children: [
                  const Text('Altima', style: _valueStyle),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Year',
            child: _DropdownField(
              child: Row(
                children: [
                  const Text('2021', style: _valueStyle),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Trim',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final String trim in _trimOptions)
                  _SelectablePill(
                    label: trim,
                    width: 120,
                    height: 40,
                    selected: _selectedTrim == trim,
                    onTap: () {
                      setState(() {
                        _selectedTrim = trim;
                      });
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Color',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int index = 0; index < _colorOptions.length; index++)
                    Padding(
                      padding: EdgeInsets.only(
                        right: index == _colorOptions.length - 1 ? 0 : 10,
                      ),
                      child: _ColorCard(
                        option: _colorOptions[index],
                        selected: _selectedColor == _colorOptions[index].id,
                        onTap: () {
                          setState(() {
                            _selectedColor = _colorOptions[index].id;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Transmission',
            child: Row(
              children: [
                for (
                  int index = 0;
                  index < _transmissionOptions.length;
                  index++
                )
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index == _transmissionOptions.length - 1
                            ? 0
                            : 10,
                      ),
                      child: _SelectablePill(
                        label: _transmissionOptions[index],
                        width: double.infinity,
                        height: 61,
                        selected:
                            _selectedTransmission ==
                            _transmissionOptions[index],
                        onTap: () {
                          setState(() {
                            _selectedTransmission = _transmissionOptions[index];
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Cylinders',
            child: Row(
              children: [
                for (int index = 0; index < _cylinderOptions.length; index++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index == _cylinderOptions.length - 1 ? 0 : 10,
                      ),
                      child: _SelectablePill(
                        label: _cylinderOptions[index],
                        width: double.infinity,
                        height: 61,
                        selected: _selectedCylinder == _cylinderOptions[index],
                        onTap: () {
                          setState(() {
                            _selectedCylinder = _cylinderOptions[index];
                          });
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Engine size',
            child: _DropdownField(
              child: Row(
                children: [
                  const Text('2.5L', style: _valueStyle),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Seats',
            child: _DropdownField(
              child: Row(
                children: [
                  const Text('5', style: _valueStyle),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Seat material',
            child: _DropdownField(
              child: Row(
                children: [
                  const Text('Leather', style: _valueStyle),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.sectionTitle.copyWith(
            color: context.appTextPrimary,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          description,
          style: AppTextStyles.bodyMuted.copyWith(
            color: context.appTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: AppSurface(
          height: 94,
          width: double.infinity,
          color: context.appSurface,
          borderRadius: AppRadius.card,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: context.appSurfaceRaised,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 22, color: context.appTextPrimary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.lightTextPrimary,
                        letterSpacing: -0.42,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: AppTextStyles.caption.copyWith(
                        color: context.appTextSecondary,
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
            Image.network(
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
                              'VIN is detected',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.label.copyWith(
                                color: context.appTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 174,
                              child: Text(
                                'We found the VIN and can use it to fetch the vehicle details.',
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

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_FieldLabel(label), const SizedBox(height: 10), child],
    );
  }
}

class _HelperRow extends StatelessWidget {
  const _HelperRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: context.appTextPrimary),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.caption.copyWith(
              color: context.appTextSecondary,
            ),
          ),
        ),
      ],
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
      color: context.appSurface,
      borderRadius: AppRadius.card,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Align(alignment: Alignment.centerLeft, child: child),
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _FieldSurface(child: child);
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
            color: context.appSurface,
            borderRadius: AppRadius.card,
            alignment: Alignment.center,
            child: Icon(icon, size: 22, color: context.appTextPrimary),
          ),
        ),
      ),
    );
  }
}

class _SelectablePill extends StatelessWidget {
  const _SelectablePill({
    required this.label,
    required this.width,
    required this.height,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final double width;
  final double height;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: selected ? context.appTextPrimary : Colors.transparent,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: context.appTextPrimary,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorCard extends StatelessWidget {
  const _ColorCard({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _ColorOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: Container(
          width: 70,
          height: 100,
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: selected ? context.appTextPrimary : Colors.transparent,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: option.color,
                  border: Border.all(color: Colors.black12),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                option.label,
                style: AppTextStyles.caption.copyWith(
                  color: context.appTextPrimary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChevronIcon extends StatelessWidget {
  const _ChevronIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.keyboard_arrow_down_rounded, size: 18);
  }
}

class _ColorOption {
  const _ColorOption({
    required this.id,
    required this.label,
    required this.color,
  });

  final String id;
  final String label;
  final Color color;
}

const TextStyle _valueStyle = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
  fontSize: 14,
  color: Colors.black,
  letterSpacing: -0.42,
);

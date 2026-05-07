import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';

const Color _whiteChipColor = Color(0xFFF7F7F7);
const Color _blackChipColor = Color(0xFF0D0D0D);
const Color _redChipColor = Color(0xFFFF1A1A);
const Color _navyChipColor = Color(0xFF081D8D);
const Color _greyChipColor = Color(0xFF8E8E8E);

const String _nissanLogoAsset = 'assets/figma/brands/nissan_logo.png';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key, required this.onContinueChanged});

  final ValueChanged<bool> onContinueChanged;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onContinueChanged(true);
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostCarTitleBlock(
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
                  Image.asset(
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                const double spacing = 10;
                final double itemWidth = (constraints.maxWidth - spacing) / 2;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (final String trim in _trimOptions)
                      _SelectablePill(
                        label: trim,
                        width: itemWidth,
                        height: 40,
                        selected: _selectedTrim == trim,
                        onTap: () {
                          setState(() {
                            _selectedTrim = trim;
                          });
                        },
                      ),
                  ],
                );
              },
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

class _DropdownField extends StatelessWidget {
  const _DropdownField({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _FieldSurface(child: child);
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
            color: context.appSurfaceRaised,
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
            color: context.appSurfaceRaised,
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

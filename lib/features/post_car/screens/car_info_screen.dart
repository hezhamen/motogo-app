import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';
import 'package:motogo_app/features/vehicle_catalog/vehicle_catalog_repository.dart';

const Color _whiteChipColor = Color(0xFFF7F7F7);
const Color _blackChipColor = Color(0xFF0D0D0D);
const Color _redChipColor = Color(0xFFFF1A1A);
const Color _navyChipColor = Color(0xFF081D8D);
const Color _greyChipColor = Color(0xFF8E8E8E);

const String _fallbackMakeLogoAsset = 'assets/figma/brands/nissan_logo.png';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({
    super.key,
    required this.onContinueChanged,
    this.onVehicleChanged,
  });

  final ValueChanged<bool> onContinueChanged;
  final ValueChanged<
    ({String? make, String? model, int? year, String? makeLogoUrl})
  >?
  onVehicleChanged;

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
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

  String? _selectedMake;
  String? _selectedMakeLogoUrl;
  String? _selectedModel;
  int? _selectedYear;
  String? _selectedTrim;

  String _selectedColor = 'black';
  String _selectedTransmission = 'Automatic';
  String _selectedCylinder = '4';

  @override
  void initState() {
    super.initState();
    _notifyCanContinue();
    _notifyVehicleChanged();
  }

  void _notifyCanContinue() {
    widget.onContinueChanged(
      _selectedMake != null &&
          _selectedModel != null &&
          _selectedYear != null &&
          _selectedTrim != null,
    );
  }

  void _notifyVehicleChanged() {
    widget.onVehicleChanged?.call((
      make: _selectedMake,
      model: _selectedModel,
      year: _selectedYear,
      makeLogoUrl: _selectedMakeLogoUrl,
    ));
  }

  Future<void> _pickMake() async {
    final makes = await VehicleCatalogRepository.instance.makes();
    final logos = await VehicleCatalogRepository.instance.makeLogos();
    if (!mounted) return;
    final picked = await _pickFromList(
      context,
      title: 'Make',
      items: makes,
      selected: _selectedMake,
      leadingImageUrlForValue: (value) => logos[value],
    );
    if (!mounted) return;
    if (picked == null || picked == _selectedMake) return;

    final logo =
        await VehicleCatalogRepository.instance.makeLogoUrl(picked) ??
        _selectedMakeLogoUrl;
    if (!mounted) return;

    setState(() {
      _selectedMake = picked;
      _selectedMakeLogoUrl = logo;
      _selectedModel = null;
      _selectedYear = null;
      _selectedTrim = null;
    });
    _notifyCanContinue();
    _notifyVehicleChanged();
  }

  Future<void> _pickModel() async {
    final make = _selectedMake;
    if (make == null) return;
    final models = await VehicleCatalogRepository.instance.modelsForMake(make);
    if (!mounted) return;
    final picked = await _pickFromList(
      context,
      title: 'Model',
      items: models,
      selected: _selectedModel,
    );
    if (!mounted) return;
    if (picked == null || picked == _selectedModel) return;

    setState(() {
      _selectedModel = picked;
      _selectedYear = null;
      _selectedTrim = null;
    });
    _notifyCanContinue();
    _notifyVehicleChanged();
  }

  Future<void> _pickYear() async {
    final make = _selectedMake;
    final model = _selectedModel;
    if (make == null || model == null) return;

    final years = await VehicleCatalogRepository.instance.yearsFor(make, model);
    final items = years.map((y) => y.toString()).toList(growable: false);
    if (!mounted) return;
    final picked = await _pickFromList(
      context,
      title: 'Year',
      items: items,
      selected: _selectedYear?.toString(),
    );
    if (!mounted) return;
    if (picked == null) return;
    final parsed = int.tryParse(picked);
    if (parsed == null || parsed == _selectedYear) return;

    setState(() {
      _selectedYear = parsed;
    });
    _notifyCanContinue();
    _notifyVehicleChanged();
  }

  @override
  Widget build(BuildContext context) {
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
            child: _TapableDropdownField(
              onTap: _pickMake,
              child: Row(
                children: [
                  _MakeLogo(
                    makeLogoUrl: _selectedMakeLogoUrl,
                    fallbackAsset: _fallbackMakeLogoAsset,
                  ),
                  const SizedBox(width: 10),
                  Text(_selectedMake ?? 'Select', style: _valueStyle),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Model',
            child: _TapableDropdownField(
              onTap: _selectedMake == null ? null : _pickModel,
              child: Row(
                children: [
                  Text(_selectedModel ?? 'Select', style: _valueStyle),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _LabeledField(
            label: 'Year',
            child: _TapableDropdownField(
              onTap: _selectedMake == null || _selectedModel == null
                  ? null
                  : _pickYear,
              child: Row(
                children: [
                  Text(
                    _selectedYear?.toString() ?? 'Select',
                    style: _valueStyle,
                  ),
                  const Spacer(),
                  const _ChevronIcon(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_selectedMake != null && _selectedModel != null) ...[
            _LabeledField(
              label: 'Trim',
              child: _TrimPicker(
                make: _selectedMake,
                model: _selectedModel,
                selected: _selectedTrim,
                onChanged: (value) {
                  setState(() => _selectedTrim = value);
                  _notifyCanContinue();
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
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

class _TapableDropdownField extends StatelessWidget {
  const _TapableDropdownField({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: _FieldSurface(child: child),
      ),
    );
  }
}

class _MakeLogo extends StatelessWidget {
  const _MakeLogo({required this.makeLogoUrl, required this.fallbackAsset});

  final String? makeLogoUrl;
  final String fallbackAsset;

  @override
  Widget build(BuildContext context) {
    final url = makeLogoUrl;
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        width: 24,
        height: 20,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            fallbackAsset,
            width: 24,
            height: 20,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(width: 24, height: 20);
            },
          );
        },
      );
    }

    return Image.asset(
      fallbackAsset,
      width: 24,
      height: 20,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(width: 24, height: 20);
      },
    );
  }
}

class _TrimPicker extends StatelessWidget {
  const _TrimPicker({
    required this.make,
    required this.model,
    required this.selected,
    required this.onChanged,
  });

  final String? make;
  final String? model;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final make = this.make;
    final model = this.model;
    if (make == null || model == null) {
      return const _FieldSurface(
        child: Text('Select make + model first', style: _valueStyle),
      );
    }

    return FutureBuilder<List<String>>(
      future: VehicleCatalogRepository.instance.trimsFor(make, model),
      builder: (context, snapshot) {
        final trims = snapshot.data ?? const <String>[];
        if (trims.isEmpty) {
          return const _FieldSurface(
            child: Text('No trims found', style: _valueStyle),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            const double spacing = 10;
            final double itemWidth = (constraints.maxWidth - spacing) / 2;

            final effectiveSelected = selected ?? trims.first;
            if (selected == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                onChanged(effectiveSelected);
              });
            }

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final trim in trims)
                  _SelectablePill(
                    label: trim,
                    width: itemWidth,
                    height: 40,
                    selected: effectiveSelected == trim,
                    onTap: () => onChanged(trim),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

Future<String?> _pickFromList(
  BuildContext context, {
  required String title,
  required List<String> items,
  required String? selected,
  String? Function(String value)? leadingImageUrlForValue,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _SearchPickerSheet(
      title: title,
      items: items,
      selected: selected,
      leadingImageUrlForValue: leadingImageUrlForValue,
    ),
  );
}

class _SearchPickerSheet extends StatefulWidget {
  const _SearchPickerSheet({
    required this.title,
    required this.items,
    required this.selected,
    this.leadingImageUrlForValue,
  });

  final String title;
  final List<String> items;
  final String? selected;
  final String? Function(String value)? leadingImageUrlForValue;

  @override
  State<_SearchPickerSheet> createState() => _SearchPickerSheetState();
}

class _SearchPickerSheetState extends State<_SearchPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.items
        .where((v) => v.toLowerCase().contains(_query.trim().toLowerCase()))
        .toList(growable: false);

    final double bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final double maxSheetHeight = MediaQuery.sizeOf(context).height * 0.75;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
          bottom: bottomInset + AppSpacing.md,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxSheetHeight),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: context.appOutlineSubtle,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: AppTextStyles.sectionTitle.copyWith(
                  color: context.appTextPrimary,
                ),
              ),
              const SizedBox(height: 10),
              AppSurface(
                height: 52,
                width: double.infinity,
                color: context.appSurfaceRaised,
                borderRadius: AppRadius.card,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: [
                    Icon(
                      Boxicons.bx_search,
                      size: 18,
                      color: context.appTextSecondary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: AppTextStyles.value.copyWith(
                            color: context.appTextSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        style: AppTextStyles.value.copyWith(
                          color: context.appTextPrimary,
                          fontSize: 16,
                        ),
                        cursorColor: context.appTextPrimary,
                        onChanged: (v) => setState(() => _query = v),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final value = filtered[index];
                    final isSelected = value == widget.selected;
                    final String? leadingUrl = widget.leadingImageUrlForValue
                        ?.call(value);
                    return _PickerOptionPill(
                      label: value,
                      leading: _BrandIcon(url: leadingUrl),
                      selected: isSelected,
                      onTap: () => Navigator.of(context).pop(value),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerOptionPill extends StatelessWidget {
  const _PickerOptionPill({
    required this.label,
    required this.leading,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Widget leading;
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
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: context.appSurfaceRaised,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: selected ? context.appTextPrimary : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              leading,
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.value.copyWith(
                    color: context.appTextPrimary,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandIcon extends StatelessWidget {
  const _BrandIcon({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final String? url = this.url;
    if (url == null || url.isEmpty) {
      return const SizedBox(width: 28, height: 28);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: 28,
        height: 28,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(width: 28, height: 28);
        },
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
    return const Icon(Boxicons.bx_chevron_down, size: 18);
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

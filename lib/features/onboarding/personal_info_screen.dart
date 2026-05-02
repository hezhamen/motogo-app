import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

/// Collects preference details used to personalize the user's feed.
class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  static const List<AppSelectOption<String>> _carBrandOptions = [
    AppSelectOption(value: 'Nissan', label: 'Nissan'),
    AppSelectOption(value: 'Toyota', label: 'Toyota'),
    AppSelectOption(value: 'Mercedes', label: 'Mercedes'),
    AppSelectOption(value: 'Hyundai', label: 'Hyundai'),
  ];

  static const List<AppSelectOption<String>> _favouriteBrandOptions = [
    AppSelectOption(value: 'BMW', label: 'BMW'),
    AppSelectOption(value: 'Audi', label: 'Audi'),
    AppSelectOption(value: 'Porsche', label: 'Porsche'),
    AppSelectOption(value: 'Lexus', label: 'Lexus'),
  ];

  static const List<AppSelectOption<String>> _carTypeOptions = [
    AppSelectOption(value: 'Sedan', label: 'Sedan'),
    AppSelectOption(value: 'SUV', label: 'SUV'),
    AppSelectOption(value: 'Coupe', label: 'Coupe'),
    AppSelectOption(value: 'Pickup', label: 'Pickup'),
  ];

  static const List<AppSelectOption<String>> _favouriteColorOptions = [
    AppSelectOption(value: 'Black', label: 'Black'),
    AppSelectOption(value: 'White', label: 'White'),
    AppSelectOption(value: 'Silver', label: 'Silver'),
    AppSelectOption(value: 'Blue', label: 'Blue'),
  ];

  String _carBrand = _carBrandOptions.first.value;
  String _favouriteBrand = _favouriteBrandOptions.first.value;
  String _carType = _carTypeOptions.first.value;
  String _favouriteColor = _favouriteColorOptions.first.value;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Personal Information', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 6),
          const Text(
            'Tell us some informations about yourself to organize the feed for you.',
            style: AppTextStyles.bodyMuted,
          ),
          const SizedBox(height: 28),
          AppSelectField<String>(
            label: 'Car Brand',
            value: _carBrand,
            options: _carBrandOptions,
            onChanged: (value) {
              setState(() {
                _carBrand = value;
              });
            },
          ),
          const SizedBox(height: 20),
          AppSelectField<String>(
            label: 'Favourite Brand',
            value: _favouriteBrand,
            options: _favouriteBrandOptions,
            onChanged: (value) {
              setState(() {
                _favouriteBrand = value;
              });
            },
          ),
          const SizedBox(height: 20),
          AppSelectField<String>(
            label: 'Car Type',
            value: _carType,
            options: _carTypeOptions,
            onChanged: (value) {
              setState(() {
                _carType = value;
              });
            },
          ),
          const SizedBox(height: 20),
          AppSelectField<String>(
            label: 'Favourite Color',
            value: _favouriteColor,
            options: _favouriteColorOptions,
            onChanged: (value) {
              setState(() {
                _favouriteColor = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

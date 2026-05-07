import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';

class RegistrationLicenseScreen extends StatefulWidget {
  const RegistrationLicenseScreen({super.key, required this.onContinueChanged});

  final ValueChanged<bool> onContinueChanged;

  @override
  State<RegistrationLicenseScreen> createState() =>
      _RegistrationLicenseScreenState();
}

class _RegistrationLicenseScreenState extends State<RegistrationLicenseScreen> {
  static const List<String> _years = <String>[
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
  ];

  String _expiryYear = '2027';
  bool _namedAfterYou = true;

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
            title: 'Vehicle Registration License Informations',
            description:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          ),
          const SizedBox(height: 36),
          AppSelectField<String>(
            label: 'Vehicle Registration License Expiry Date',
            value: _expiryYear,
            options: [
              for (final year in _years)
                AppSelectOption(value: year, label: year),
            ],
            onChanged: (value) => setState(() => _expiryYear = value),
          ),
          const SizedBox(height: 16),
          Text(
            'Is your Vehicle Registration License is named after you?',
            style: AppTextStyles.label.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: PostCarChoiceCheckCard(
                  label: 'No',
                  selected: !_namedAfterYou,
                  onTap: () => setState(() => _namedAfterYou = false),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PostCarChoiceCheckCard(
                  label: 'Yes',
                  selected: _namedAfterYou,
                  onTap: () => setState(() => _namedAfterYou = true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

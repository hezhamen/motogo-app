import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';

class CarPlateScreen extends StatefulWidget {
  const CarPlateScreen({super.key, required this.onContinueChanged});

  final ValueChanged<bool> onContinueChanged;

  @override
  State<CarPlateScreen> createState() => _CarPlateScreenState();
}

class _CarPlateScreenState extends State<CarPlateScreen> {
  static const List<String> _plateTypes = <String>['Private', 'Commercial'];
  static const List<String> _plateFirstNumbers = <String>[
    '20',
    '21',
    '22',
    '23',
    '24',
  ];
  static const List<String> _plateLetters = <String>['A', 'B', 'L', 'M', 'S'];

  String _plateType = 'Private';
  String _plateBasicNumber = '21';
  String _plateBasicLetter = 'L';
  String _carNumber = '3166';
  bool _sellPlateWithCar = true;

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
            title: 'Car Plate',
            description:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          ),
          const SizedBox(height: 36),
          Center(
            child: _CarPlatePreview(
              basicsLeft: _plateBasicNumber,
              basicsRight: _plateBasicLetter,
              carNumber: _carNumber,
            ),
          ),
          const SizedBox(height: 36),
          AppSelectField<String>(
            label: 'Plate Type',
            value: _plateType,
            options: [
              for (final option in _plateTypes)
                AppSelectOption(value: option, label: option),
            ],
            onChanged: (value) => setState(() => _plateType = value),
          ),
          const SizedBox(height: 16),
          Text(
            'Plate Basics',
            style: AppTextStyles.label.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: AppSelectField<String>(
                  label: 'Plate Basics',
                  value: _plateBasicNumber,
                  options: [
                    for (final option in _plateFirstNumbers)
                      AppSelectOption(value: option, label: option),
                  ],
                  onChanged: (value) =>
                      setState(() => _plateBasicNumber = value),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppSelectField<String>(
                  label: 'Plate Basics',
                  value: _plateBasicLetter,
                  options: [
                    for (final option in _plateLetters)
                      AppSelectOption(value: option, label: option),
                  ],
                  onChanged: (value) =>
                      setState(() => _plateBasicLetter = value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppFormFieldCard(
            label: 'Car Number',
            child: TextFormField(
              initialValue: _carNumber,
              style: AppTextStyles.value.copyWith(
                color: context.appTextPrimary,
              ),
              keyboardType: TextInputType.number,
              cursorColor: context.appTextPrimary,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
              ),
              onChanged: (value) => setState(() => _carNumber = value),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Will you sell the plate with the car?',
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
                  selected: !_sellPlateWithCar,
                  onTap: () => setState(() => _sellPlateWithCar = false),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PostCarChoiceCheckCard(
                  label: 'Yes',
                  selected: _sellPlateWithCar,
                  onTap: () => setState(() => _sellPlateWithCar = true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CarPlatePreview extends StatelessWidget {
  const _CarPlatePreview({
    required this.basicsLeft,
    required this.basicsRight,
    required this.carNumber,
  });

  final String basicsLeft;
  final String basicsRight;
  final String carNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.694),
        borderRadius: BorderRadius.circular(5.388),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26.753,
            height: 64,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.black, width: 2.694),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.388),
                bottomLeft: Radius.circular(5.388),
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'I\nR\nQ\nKR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.66,
                fontWeight: FontWeight.w800,
                height: 1.15,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10.776),
          Text(
            '$basicsLeft $basicsRight',
            style: const TextStyle(
              fontSize: 43.038,
              fontWeight: FontWeight.w700,
              height: 1,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 13.449),
          Text(
            carNumber,
            style: const TextStyle(
              fontSize: 43.038,
              fontWeight: FontWeight.w700,
              height: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

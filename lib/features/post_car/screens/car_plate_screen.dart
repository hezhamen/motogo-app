import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  late final TextEditingController _carNumberController = TextEditingController(
    text: _carNumber,
  );

  @override
  void dispose() {
    _carNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onContinueChanged(true);
    });

    final double keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final double previewScale = keyboardInset > 0 ? 0.82 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PostCarTitleBlock(
          title: 'Car Plate',
          description: 'Enter plate details exactly as shown on the vehicle.',
        ),
        const SizedBox(height: 24),
        Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            scale: previewScale,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: _CarPlatePreview(
                      basicsLeft: _plateBasicNumber,
                      basicsRight: _plateBasicLetter,
                      carNumber: _carNumber,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: keyboardInset + 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        label: 'Number',
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
                        label: 'Letter',
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
                  label: 'Car Number (max 5 digits)',
                  child: TextField(
                    controller: _carNumberController,
                    style: AppTextStyles.value.copyWith(
                      color: context.appTextPrimary,
                    ),
                    keyboardType: TextInputType.number,
                    cursorColor: context.appTextPrimary,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                    onChanged: (value) {
                      setState(() => _carNumber = value);
                    },
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
          ),
        ),
      ],
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
          _TickerDigits(
            value: carNumber,
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

class _TickerDigits extends StatelessWidget {
  const _TickerDigits({required this.value, required this.style});

  final String value;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) {
      return Text(value, style: style);
    }

    final TextPainter painter = TextPainter(
      text: TextSpan(text: '0', style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    final double digitWidth = painter.width;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final ch in digitsOnly.split(''))
          _DigitTicker(
            digit: int.tryParse(ch) ?? 0,
            style: style,
            width: digitWidth,
          ),
      ],
    );
  }
}

class _DigitTicker extends StatefulWidget {
  const _DigitTicker({
    required this.digit,
    required this.style,
    required this.width,
  });

  final int digit;
  final TextStyle style;
  final double width;

  @override
  State<_DigitTicker> createState() => _DigitTickerState();
}

class _DigitTickerState extends State<_DigitTicker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 180),
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _DigitTicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.digit != widget.digit) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = widget.style.fontSize ?? 16;
    final double lineHeight = (widget.style.height ?? 1) * fontSize;
    final int target = widget.digit.clamp(0, 9);

    return ClipRect(
      child: SizedBox(
        width: widget.width,
        height: lineHeight,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double t = Curves.easeOutCubic.transform(_controller.value);
            final double translateY = -lineHeight * (target * t);
            return Transform.translate(
              offset: Offset(0, translateY),
              child: child,
            );
          },
          child: OverflowBox(
            alignment: Alignment.topCenter,
            minWidth: widget.width,
            maxWidth: widget.width,
            minHeight: lineHeight * 10,
            maxHeight: lineHeight * 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i <= 9; i++) Text('$i', style: widget.style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

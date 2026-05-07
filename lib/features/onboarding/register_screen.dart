import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter/services.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const String _iraqFlagAssetPath =
      'assets/figma/onboarding/register_hero.png';

  static const List<AppSelectOption<String>> _cityOptions = [
    AppSelectOption(value: 'Sulaymaniyah', label: 'Sulaymaniyah'),
    AppSelectOption(value: 'Erbil', label: 'Erbil'),
    AppSelectOption(value: 'Duhok', label: 'Duhok'),
    AppSelectOption(value: 'Baghdad', label: 'Baghdad'),
    AppSelectOption(value: 'Basra', label: 'Basra'),
  ];

  String? _selectedCity;
  DateTime? _selectedDateOfBirth;

  late final TextEditingController _phoneController;
  bool _isPhoneValid = false;
  final OverlayPortalController _emailInfoController =
      OverlayPortalController();
  final LayerLink _emailInfoLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _isPhoneValid = false;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime(2002, 1, 1),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDateOfBirth = pickedDate;
    });
  }

  String _formatDate(DateTime value) {
    return '${value.day}/${value.month}/${value.year}';
  }

  static String _digitsOnly(String value) {
    return value.replaceAll(RegExp(r'\D'), '');
  }

  static bool _isValidPhoneNumber(String value) {
    final String digits = _digitsOnly(value);
    return digits.length == 10 && digits.startsWith('7');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create your account',
            style: AppTextStyles.sectionTitle.copyWith(
              color: context.appTextPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Set up your profile to get started with MotoGo and personalize your experience.',
            style: AppTextStyles.bodyMuted.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 28),
          const AppFormFieldCard(
            label: 'Full Name',
            child: AppTextField(
              initialValue: '',
              textInputAction: TextInputAction.next,
              hintText: 'Your full name',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppFormFieldCard(
            label: 'Phone Number',
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    _iraqFlagAssetPath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 24,
                      height: 24,
                      color: context.appTextTertiary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '+964',
                  style: AppTextStyles.bodyMuted.copyWith(
                    color: context.appTextSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppTextField(
                    initialValue: '',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyles.valueLarge,
                    hintText: '7XX XXX XXXX',
                    inputFormatters: [_PhoneMaskFormatter()],
                    onChanged: (value) {
                      final bool next = _isValidPhoneNumber(value);
                      if (_isPhoneValid == next) return;
                      setState(() => _isPhoneValid = next);
                    },
                  ),
                ),
                if (_isPhoneValid) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    Boxicons.bx_check,
                    size: 20,
                    color: Colors.green.shade600,
                    semanticLabel: 'Phone number valid',
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppFormFieldCard(
            label: 'Email Address',
            child: Row(
              children: [
                const Expanded(
                  child: AppTextField(
                    initialValue: '',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    hintText: 'name@example.com',
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                OverlayPortal(
                  controller: _emailInfoController,
                  overlayChildBuilder: (context) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: _emailInfoController.hide,
                          ),
                        ),
                        CompositedTransformFollower(
                          link: _emailInfoLink,
                          showWhenUnlinked: false,
                          targetAnchor: Alignment.topRight,
                          followerAnchor: Alignment.bottomRight,
                          offset: const Offset(0, -10),
                          child: Material(
                            color: Colors.transparent,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 260),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context.appSurfaceRaised,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: context.appOutlineSubtle.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    'Optional. We\'ll use your email to send account updates, offers, and important news.',
                                    style: AppTextStyles.caption.copyWith(
                                      color: context.appTextPrimary,
                                      height: 1.25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  child: CompositedTransformTarget(
                    link: _emailInfoLink,
                    child: Semantics(
                      label: 'Email info',
                      button: true,
                      child: GestureDetector(
                        onTap: () {
                          if (_emailInfoController.isShowing) {
                            _emailInfoController.hide();
                          } else {
                            _emailInfoController.show();
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Boxicons.bx_info_circle,
                            size: 18,
                            color: context.appTextSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppSelectField<String>(
                  label: 'City/Province',
                  value: _selectedCity,
                  placeholder: 'Select city',
                  options: _cityOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppFormFieldCard(
                  label: 'Date of Birth',
                  child: GestureDetector(
                    onTap: _pickDateOfBirth,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDateOfBirth == null
                                ? 'Select DOB'
                                : _formatDate(_selectedDateOfBirth!),
                            style: AppTextStyles.value.copyWith(
                              color: _selectedDateOfBirth == null
                                  ? context.appTextPrimary.withValues(
                                      alpha: 0.45,
                                    )
                                  : context.appTextPrimary,
                            ),
                          ),
                        ),
                        Icon(
                          Boxicons.bx_calendar,
                          size: 18,
                          color: context.appTextPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhoneMaskFormatter extends TextInputFormatter {
  static String _digitsOnly(String value) =>
      value.replaceAll(RegExp(r'\D'), '');

  static String _format(String digits) {
    final String cleaned = digits;
    final StringBuffer out = StringBuffer();

    for (int i = 0; i < cleaned.length && i < 10; i++) {
      if (i == 3) out.write(' ');
      if (i == 6) out.write(' ');
      out.write(cleaned[i]);
    }

    return out.toString();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digits = _digitsOnly(newValue.text);
    final String formatted = _format(digits);

    // Put cursor at end; good enough for now.
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
      composing: TextRange.empty,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const String _iraqFlagUrl =
      'https://www.figma.com/api/mcp/asset/de7c78ce-da77-40b4-8db9-499f534b8318';

  static const List<AppSelectOption<String>> _cityOptions = [
    AppSelectOption(value: 'Sulaymaniyah', label: 'Sulaymaniyah'),
    AppSelectOption(value: 'Erbil', label: 'Erbil'),
    AppSelectOption(value: 'Duhok', label: 'Duhok'),
    AppSelectOption(value: 'Baghdad', label: 'Baghdad'),
    AppSelectOption(value: 'Basra', label: 'Basra'),
  ];

  String _selectedCity = _cityOptions.first.value;
  DateTime _selectedDateOfBirth = DateTime(2002, 1, 1);

  Future<void> _pickDateOfBirth() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create your account', style: AppTextStyles.title),
          const SizedBox(height: 14),
          const Text(
            'Set up your profile to get started with MotoGo and personalize your experience.',
            style: AppTextStyles.bodyMuted,
          ),
          const SizedBox(height: 22),
          const AppFormFieldCard(
            label: 'Full Name',
            child: AppTextField(
              initialValue: 'Hezha Amen',
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppFormFieldCard(
            label: 'Phone Number',
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    _iraqFlagUrl,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 24,
                      height: 24,
                      color: AppColors.progressInactive,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                const Text('+964', style: AppTextStyles.bodyMuted),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(
                  child: AppTextField(
                    initialValue: '777 451 6006',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyles.valueLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const AppFormFieldCard(
            label: 'Email Address',
            helper: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  LucideIcons.info,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Optional. We\'ll use your email to send account updates, offers, and important news.',
                    style: AppTextStyles.caption,
                  ),
                ),
              ],
            ),
            child: AppTextField(
              initialValue: 'hezhamen@gmail.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppSelectField<String>(
            label: 'City/Province',
            value: _selectedCity,
            options: _cityOptions,
            onChanged: (value) {
              setState(() {
                _selectedCity = value;
              });
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppFormFieldCard(
            label: 'Date of Birth',
            child: GestureDetector(
              onTap: _pickDateOfBirth,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatDate(_selectedDateOfBirth),
                      style: AppTextStyles.value,
                    ),
                  ),
                  const Icon(
                    LucideIcons.calendarDays,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key, required this.onContinueChanged});

  final ValueChanged<bool> onContinueChanged;

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _currency = '\$';
  String _price = '20,000';
  bool _hasFine = true;
  String _fineCurrency = 'IQD';
  String _fineAmount = '300,000';
  bool _payFineYourself = true;

  @override
  Widget build(BuildContext context) {
    final bool canContinue = _price.trim().isNotEmpty;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onContinueChanged(canContinue);
    });

    final String totalText = _computeTotalText();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostCarTitleBlock(
            title: 'Vehicle Price',
            description:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          ),
          const SizedBox(height: 36),
          Text(
            'Enter Your Price',
            style: AppTextStyles.label.copyWith(
              color: context.appTextSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              AppSurface(
                height: 61,
                borderRadius: AppRadius.card,
                color: context.appSurface,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _currency,
                      style: AppTextStyles.sectionTitle.copyWith(
                        color: context.appTextPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      LucideIcons.chevronDown,
                      size: 18,
                      color: context.appTextPrimary,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppSurface(
                  height: 61,
                  borderRadius: AppRadius.card,
                  color: context.appSurface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Center(
                    child: TextFormField(
                      initialValue: _price,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.72,
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: context.appTextPrimary,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                      onChanged: (value) => setState(() => _price = value),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Is there any Fine on the car',
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
                  selected: !_hasFine,
                  onTap: () => setState(() => _hasFine = false),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PostCarChoiceCheckCard(
                  label: 'Yes',
                  selected: _hasFine,
                  onTap: () => setState(() => _hasFine = true),
                ),
              ),
            ],
          ),
          if (_hasFine) ...[
            const SizedBox(height: 16),
            Text(
              'Enter Your Vehicle Fine Amount',
              style: AppTextStyles.label.copyWith(
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                AppSurface(
                  height: 61,
                  borderRadius: AppRadius.card,
                  color: context.appSurface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _fineCurrency,
                        style: AppTextStyles.sectionTitle.copyWith(
                          color: context.appTextPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        LucideIcons.chevronDown,
                        size: 18,
                        color: context.appTextPrimary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppSurface(
                    height: 61,
                    borderRadius: AppRadius.card,
                    color: context.appSurface,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Center(
                      child: TextFormField(
                        initialValue: _fineAmount,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.72,
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: context.appTextPrimary,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        onChanged: (value) =>
                            setState(() => _fineAmount = value),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Will you pay the fine amount yourself?',
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
                    selected: !_payFineYourself,
                    onTap: () => setState(() => _payFineYourself = false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PostCarChoiceCheckCard(
                    label: 'Yes',
                    selected: _payFineYourself,
                    onTap: () => setState(() => _payFineYourself = true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const PostCarHelperRow(
              icon: LucideIcons.info,
              text:
                  'Email Address is used to send you latest updates and news and its optional in case you don’t want to add.',
            ),
          ],
          const SizedBox(height: 16),
          AppSurface(
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _currency,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.72,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You Car Total Price Will be',
                        style: AppTextStyles.caption.copyWith(
                          color: context.appTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        totalText,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.72,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _computeTotalText() {
    final int price = _parseInt(_price);
    if (!_hasFine) {
      return '${_currency}${_formatInt(price)}';
    }
    final int fine = _parseInt(_fineAmount);
    final int fineAsListingCurrency = fine ~/ 1500;
    final int total = price - fineAsListingCurrency;
    return '${_currency}${_formatInt(total)}';
  }

  int _parseInt(String value) {
    final String digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  String _formatInt(int value) {
    final String raw = value.toString();
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < raw.length; i++) {
      final int reverseIndex = raw.length - i;
      buffer.write(raw[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }
    return buffer.toString();
  }
}

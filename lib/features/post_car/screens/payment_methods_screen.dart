import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

enum PaymentMethod { fastpay, fib, zaincash, qiCard }

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key, required this.onContinueChanged});

  final ValueChanged<bool> onContinueChanged;

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  PaymentMethod? _selected;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onContinueChanged(_selected != null);
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Payment Methods',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.6,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Choose how you want to pay to publish your listing.',
              style: AppTextStyles.value.copyWith(
                fontSize: 14,
                letterSpacing: -0.42,
                color: context.appTextSecondary,
              ),
            ),
            const SizedBox(height: 24),
            AppSurface(
              height: 94,
              width: double.infinity,
              color: context.appSurface,
              borderRadius: AppRadius.card,
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      'IQD',
                      style: AppTextStyles.value.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: -0.48,
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
                          'Your payment amount',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10,
                            letterSpacing: -0.3,
                            color: context.appTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '5,000 IQD',
                          style: AppTextStyles.sectionTitle.copyWith(
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
            const SizedBox(height: 36),
            Text(
              'Available methods',
              style: AppTextStyles.sectionTitle.copyWith(
                color: context.appTextPrimary,
              ),
            ),
            const SizedBox(height: 24),
            _MethodTile(
              label: 'Fastpay',
              assetPath: 'assets/figma/post_car/payment/fastpay.png',
              selected: _selected == PaymentMethod.fastpay,
              onTap: () => setState(() => _selected = PaymentMethod.fastpay),
            ),
            const SizedBox(height: 16),
            _MethodTile(
              label: 'FIB',
              assetPath: 'assets/figma/post_car/payment/fib.png',
              selected: _selected == PaymentMethod.fib,
              onTap: () => setState(() => _selected = PaymentMethod.fib),
            ),
            const SizedBox(height: 16),
            _MethodTile(
              label: 'Zaincash',
              assetPath: 'assets/figma/post_car/payment/zaincash.png',
              selected: _selected == PaymentMethod.zaincash,
              onTap: () => setState(() => _selected = PaymentMethod.zaincash),
            ),
            const SizedBox(height: 16),
            _MethodTile(
              label: 'Qi Card',
              assetPath: 'assets/figma/post_car/payment/qi_card.png',
              selected: _selected == PaymentMethod.qiCard,
              onTap: () => setState(() => _selected = PaymentMethod.qiCard),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.label,
    required this.assetPath,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String assetPath;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: AppSurface(
          height: 61,
          width: double.infinity,
          color: context.appSurface,
          borderRadius: AppRadius.card,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Image.asset(assetPath, fit: BoxFit.contain),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.value.copyWith(
                    color: context.appTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.42,
                  ),
                ),
              ),
              _RadioCircle(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _RadioCircle extends StatelessWidget {
  const _RadioCircle({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.appTextPrimary, width: 1.6),
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: selected ? 1 : 0,
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: context.appTextPrimary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

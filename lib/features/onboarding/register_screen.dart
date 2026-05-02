import 'package:flutter/material.dart';

import '../../design_system/app_design_system.dart';
import '../../design_system/app_widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String _iraqFlagUrl =
      'https://www.figma.com/api/mcp/asset/de7c78ce-da77-40b4-8db9-499f534b8318';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const OnboardingProgress(activeStep: 0),
                      const SizedBox(height: AppSpacing.xl),
                      const Text('Register', style: AppTextStyles.title),
                      const SizedBox(height: 14),
                      const Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: AppTextStyles.bodyMuted,
                      ),
                      const SizedBox(height: 22),
                      const AppFormFieldCard(
                        label: 'Full Name',
                        child: Text('Hezha Amen', style: AppTextStyles.value),
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
                                errorBuilder: (_, __, ___) => Container(
                                  width: 24,
                                  height: 24,
                                  color: AppColors.progressInactive,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            const Text('+964', style: AppTextStyles.bodyMuted),
                            const SizedBox(width: 10),
                            const Text(
                              '777 451 6006',
                              style: AppTextStyles.valueLarge,
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
                              Icons.info_outline,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                'Email Address is used to send you latest updates and news and its optional in case you don’t want to add.',
                                style: AppTextStyles.caption,
                              ),
                            ),
                          ],
                        ),
                        child: Text(
                          'hezhamen@gmail.com',
                          style: AppTextStyles.value,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const AppFormFieldCard(
                        label: 'City/Province',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sulaymaniyah', style: AppTextStyles.value),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.textPrimary,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const AppFormFieldCard(
                        label: 'Date of Birth',
                        child: Text('1/1/2002', style: AppTextStyles.value),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppPrimaryButton(label: 'Register', onPressed: () {}),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

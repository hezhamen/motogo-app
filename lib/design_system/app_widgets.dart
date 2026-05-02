import 'package:flutter/material.dart';

import 'app_design_system.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 61,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
        child: Text(label, style: AppTextStyles.button),
      ),
    );
  }
}

class AppFormFieldCard extends StatelessWidget {
  const AppFormFieldCard({
    super.key,
    required this.label,
    required this.child,
    this.helper,
  });

  final String label;
  final Widget child;
  final Widget? helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          height: 61,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceField,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          alignment: Alignment.centerLeft,
          child: child,
        ),
        if (helper != null) ...[
          const SizedBox(height: AppSpacing.xs),
          helper!,
        ],
      ],
    );
  }
}

class OnboardingProgress extends StatelessWidget {
  const OnboardingProgress({
    super.key,
    required this.activeStep,
    this.totalSteps = 3,
  });

  final int activeStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final bool isActive = index == activeStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 11),
            height: 2,
            color: isActive ? AppColors.progressActive : AppColors.progressInactive,
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/onboarding/feed_organizing_screen.dart';
import 'package:motogo_app/features/onboarding/otp_screen.dart';
import 'package:motogo_app/features/onboarding/personal_info_screen.dart';
import 'package:motogo_app/features/onboarding/register_screen.dart';

/// Coordinates onboarding while keeping the progress stepper fixed in place.
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  static const String _phoneNumber = '+964 777 451 6006';
  static const Duration _pageDuration = Duration(milliseconds: 280);

  final PageController _pageController = PageController();
  int _activeStep = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToStep(int step) async {
    if (step == _activeStep) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _activeStep = step);
    await _pageController.animateToPage(
      step,
      duration: _pageDuration,
      curve: Curves.easeOutCubic,
    );
  }

  void _goBack() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_activeStep == 0) {
      Navigator.of(context).maybePop();
      return;
    }

    _goToStep(_activeStep - 1);
  }

  void _finishPersonalInfo() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const FeedOrganizingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: _goBack,
                    icon: const Icon(LucideIcons.arrowLeft, size: 18),
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  ),
                ),
                const SizedBox(height: 10),
                OnboardingProgress(activeStep: _activeStep),
                const SizedBox(height: AppSpacing.xl),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const RegisterScreen(),
                      OtpScreen(
                        phoneNumber: _phoneNumber,
                        isActive: _activeStep == 1,
                        onEditNumber: () => _goToStep(0),
                      ),
                      const PersonalInfoScreen(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  label: switch (_activeStep) {
                    0 => 'Create account',
                    1 => 'Verify number',
                    _ => 'Save preferences',
                  },
                  onPressed: switch (_activeStep) {
                    0 => () => _goToStep(1),
                    1 => () => _goToStep(2),
                    _ => _finishPersonalInfo,
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

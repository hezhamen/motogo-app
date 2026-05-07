import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/home/home_screen.dart';

/// Shows the final onboarding state while the feed is prepared.
class FeedOrganizingScreen extends StatelessWidget {
  const FeedOrganizingScreen({super.key});

  static const String _loaderAssetPath =
      'assets/figma/onboarding/feed_organizing.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
              Column(
                children: [
                  Image.asset(
                    _loaderAssetPath,
                    width: 64,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Getting your feed ready',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.sectionTitle.copyWith(
                      color: context.appTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'We\'re setting up your recommendations based on the preferences you selected.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMuted.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AppPrimaryButton(
                label: 'Start exploring',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

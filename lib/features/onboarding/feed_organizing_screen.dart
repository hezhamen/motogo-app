import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

/// Shows the final onboarding state while the feed is prepared.
class FeedOrganizingScreen extends StatelessWidget {
  const FeedOrganizingScreen({super.key});

  static const String _loaderAssetUrl =
      'https://www.figma.com/api/mcp/asset/2f3931e5-3a64-4187-ad07-ec27d160f30e';

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
                  Image.network(
                    _loaderAssetUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        width: 64,
                        height: 64,
                        child: CircularProgressIndicator(strokeWidth: 4),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const Text(
                    'Organizing Your Feed',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.sectionTitle,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Tell us some informations about yourself to organize the feed for you.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMuted,
                  ),
                ],
              ),
              const Spacer(),
              AppPrimaryButton(label: 'Explore', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

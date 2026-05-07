import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/onboarding/onboarding_flow.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String _phoneNumber = '+964 777 451 6006';

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewPadding = MediaQuery.paddingOf(context);
    final double bottomNavHeight = viewPadding.bottom + 91;

    return Scaffold(
      backgroundColor: context.appBackground,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Row(
                    children: [
                      const SizedBox.square(dimension: 36),
                      const Spacer(),
                      Text(
                        'Profile',
                        style: AppTextStyles.valueLarge.copyWith(
                          color: context.appTextPrimary,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox.square(dimension: 36),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSurface(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(AppSpacing.md),
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 86,
                                height: 86,
                                decoration: BoxDecoration(
                                  color: context.appSurface,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Boxicons.bxs_user,
                                  size: 30,
                                  color: context.appTextPrimary.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Hezha Men',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.valueLarge.copyWith(
                                  color: context.appTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _phoneNumber,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.value.copyWith(
                                  color: context.appTextSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppSurface(
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              _DevMenuItem(
                                icon: Boxicons.bxs_flag,
                                label: 'Start onboarding',
                                badgeLabel: 'DEV',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => const OnboardingFlow(),
                                    ),
                                  );
                                },
                              ),
                              _DividerLine(color: context.appOutlineSubtle),
                              _LoggedInMenuItem(onTap: () {}),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'SHORTCUTS',
                          style: AppTextStyles.caption.copyWith(
                            color: context.appTextTertiary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AppSurface(
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              _ActionRow(
                                icon: Boxicons.bxs_bookmark,
                                label: 'Saved cars',
                                onTap: () {},
                              ),
                              _DividerLine(color: context.appOutlineSubtle),
                              _ActionRow(
                                icon: Boxicons.bxs_car,
                                label: 'My listings',
                                onTap: () {},
                              ),
                              _DividerLine(color: context.appOutlineSubtle),
                              _ActionRow(
                                icon: Boxicons.bxs_credit_card,
                                label: 'Payments',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'SETTINGS',
                          style: AppTextStyles.caption.copyWith(
                            color: context.appTextTertiary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AppSurface(
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              _ActionRow(
                                icon: Boxicons.bxs_bell,
                                label: 'Notifications',
                                onTap: () {},
                              ),
                              _DividerLine(color: context.appOutlineSubtle),
                              _ActionRow(
                                icon: Boxicons.bxs_lock_alt,
                                label: 'Privacy',
                                onTap: () {},
                              ),
                              _DividerLine(color: context.appOutlineSubtle),
                              _ActionRow(
                                icon: Boxicons.bxs_help_circle,
                                label: 'Help & support',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        AppSurface(
                          clipBehavior: Clip.hardEdge,
                          child: _ActionRow(
                            icon: Boxicons.bxs_log_out,
                            label: 'Log out',
                            danger: true,
                            onTap: null,
                          ),
                        ),
                        SizedBox(height: bottomNavHeight + 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null;
    final Color baseColor = danger ? context.appAccent : context.appTextPrimary;
    final Color color = isDisabled
        ? baseColor.withValues(alpha: 0.35)
        : baseColor;
    return Semantics(
      label: label,
      button: !isDisabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 15,
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.value.copyWith(
                      color: color,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Boxicons.bx_chevron_right,
                  size: 18,
                  color: isDisabled
                      ? context.appTextPrimary.withValues(alpha: 0.25)
                      : context.appTextPrimary.withValues(alpha: 0.55),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoggedInMenuItem extends StatelessWidget {
  const _LoggedInMenuItem({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Edit profile',
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 15,
            ),
            child: Row(
              children: [
                Icon(
                  Boxicons.bxs_user,
                  size: 20,
                  color: context.appTextPrimary,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Edit profile',
                    style: AppTextStyles.value.copyWith(
                      color: context.appTextPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '@hezhamen',
                  style: AppTextStyles.value.copyWith(
                    color: context.appTextSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Boxicons.bx_chevron_right,
                  size: 18,
                  color: context.appTextPrimary.withValues(alpha: 0.55),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DevMenuItem extends StatelessWidget {
  const _DevMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badgeLabel,
  });

  final IconData icon;
  final String label;
  final String? badgeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 15,
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: context.appTextPrimary),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.value.copyWith(
                      color: context.appTextPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (badgeLabel case final String badgeLabel) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: context.appSurface,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: context.appOutlineSubtle.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      badgeLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: context.appTextSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Icon(
                  Boxicons.bx_chevron_right,
                  size: 18,
                  color: context.appTextPrimary.withValues(alpha: 0.55),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine({required this.color});

  final Color color;
  static const double _startInset = 50;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: _startInset),
      child: Container(height: 1, color: color.withValues(alpha: 0.08)),
    );
  }
}

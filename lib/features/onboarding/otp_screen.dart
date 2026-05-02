import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';

/// Lets a user enter the phone verification code sent during registration.
class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.phoneNumber,
    this.initialCode = '673',
    this.onEditNumber,
    this.isActive = false,
  });

  final String phoneNumber;
  final String initialCode;
  final VoidCallback? onEditNumber;
  final bool isActive;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final TextEditingController _codeController;
  final FocusNode _codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.initialCode);
    _requestFocusWhenActive();
  }

  @override
  void didUpdateWidget(covariant OtpScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isActive && widget.isActive) {
      _requestFocusWhenActive();
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  void _editNumber() {
    _codeFocusNode.unfocus();
    widget.onEditNumber?.call();
    if (widget.onEditNumber == null) {
      Navigator.of(context).maybePop();
    }
  }

  void _resendCode() {
    _codeController.clear();
    _codeFocusNode.requestFocus();
  }

  void _requestFocusWhenActive() {
    if (!widget.isActive) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _codeFocusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verify your phone number',
            style: AppTextStyles.sectionTitle,
          ),
          const SizedBox(height: 6),
          _VerificationMessage(
            phoneNumber: widget.phoneNumber,
            onEditNumber: _editNumber,
          ),
          const SizedBox(height: 28),
          const Text('Verification code', style: AppTextStyles.label),
          const SizedBox(height: 12),
          _OtpCodeInput(controller: _codeController, focusNode: _codeFocusNode),
          const SizedBox(height: 12),
          _ResendCodePrompt(onResend: _resendCode),
        ],
      ),
    );
  }
}

class _VerificationMessage extends StatelessWidget {
  const _VerificationMessage({
    required this.phoneNumber,
    required this.onEditNumber,
  });

  final String phoneNumber;
  final VoidCallback onEditNumber;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.bodyMuted,
        children: [
          const TextSpan(text: 'We sent a 6-digit code to '),
          TextSpan(text: '$phoneNumber. '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: onEditNumber,
              child: const Text(
                'Change number',
                style: AppTextStyles.inlineAction,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpCodeInput extends StatelessWidget {
  const _OtpCodeInput({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Six digit verification code',
      textField: true,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Stack(
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, child) {
                return Row(
                  children: List.generate(6, (index) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index == 5 ? 0 : 10),
                        child: AppOtpCell(
                          value: index < value.text.length
                              ? value.text[index]
                              : '-',
                          isPlaceholder: index >= value.text.length,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0,
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onTapOutside: (_) => focusNode.unfocus(),
                  onSubmitted: (_) => focusNode.unfocus(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResendCodePrompt extends StatelessWidget {
  const _ResendCodePrompt({required this.onResend});

  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(LucideIcons.info, size: 16, color: AppColors.textPrimary),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.label,
              children: [
                const TextSpan(text: 'Didn’t receive a code? '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: onResend,
                    child: const Text(
                      'Send again',
                      style: AppTextStyles.inlineActionSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/post_car_screens.dart';

/// Orchestrates the post-a-car flow inside one shared stepper shell.
class PostCarFlow extends StatefulWidget {
  const PostCarFlow({super.key});

  @override
  State<PostCarFlow> createState() => _PostCarFlowState();
}

class _PostCarFlowState extends State<PostCarFlow> {
  static const Duration _pageDuration = Duration(milliseconds: 280);
  static const Color _flowBackgroundColor = Colors.white;
  static const Color _flowSurfaceColor = Color(0xFFF5F5F5);

  final PageController _pageController = PageController();
  int _activeStep = 0;
  int _pageIndex = 0;
  bool _canContinue = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _stepForPage(int pageIndex) {
    return switch (pageIndex) {
      0 => 0, // choice
      1 || 2 => 1, // vin + car info
      3 => 2, // car pictures
      4 => 3, // car paints
      5 => 4, // car plate
      6 => 5, // registration license
      7 => 6, // price
      _ => 0,
    };
  }

  Future<void> _goToPage(int pageIndex, {required int activeStep}) async {
    if (_pageIndex == pageIndex && _activeStep == activeStep) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _pageIndex = pageIndex;
      _activeStep = activeStep;
      _canContinue = false;
    });

    await _pageController.animateToPage(
      pageIndex,
      duration: _pageDuration,
      curve: Curves.easeOutCubic,
    );
  }

  void _goBack() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_pageIndex == 0) {
      Navigator.of(context).maybePop();
      return;
    }

    final int previousPage = _pageIndex - 1;
    _goToPage(previousPage, activeStep: _stepForPage(previousPage));
  }

  void _openVinLookup() {
    _goToPage(1, activeStep: 1);
  }

  void _openManualEntry() {
    _goToPage(2, activeStep: 1);
  }

  void _continueFromVin() {
    _goToPage(2, activeStep: 1);
  }

  void _continue() {
    if (!_canContinue) {
      return;
    }
    final int nextPage = (_pageIndex + 1).clamp(0, 7);
    _goToPage(nextPage, activeStep: _stepForPage(nextPage));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData baseTheme = buildAppTheme(brightness: Brightness.light);
    final ThemeData flowTheme = baseTheme.copyWith(
      scaffoldBackgroundColor: _flowBackgroundColor,
      colorScheme: baseTheme.colorScheme.copyWith(
        surface: _flowSurfaceColor,
        surfaceContainerHighest: _flowSurfaceColor,
      ),
    );

    return Theme(
      data: flowTheme,
      child: AppFlowScaffold(
        activeStep: _activeStep,
        totalSteps: 7,
        backgroundColor: context.appBackground,
        onBack: _goBack,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            PostCarChoiceScreen(
              onEnterVinCode: _openVinLookup,
              onEnterCarManually: _openManualEntry,
            ),
            VinCodeScreen(
              onContinueChanged: (value) =>
                  setState(() => _canContinue = value),
            ),
            CarInfoScreen(
              onContinueChanged: (value) =>
                  setState(() => _canContinue = value),
            ),
            CarPicturesScreen(
              onContinueChanged: (value) =>
                  setState(() => _canContinue = value),
            ),
            CarPaintsScreen(
              onContinueChanged: (value) =>
                  setState(() => _canContinue = value),
            ),
            CarPlateScreen(
              onContinueChanged: (value) =>
                  setState(() => _canContinue = value),
            ),
            RegistrationLicenseScreen(
              onContinueChanged: (value) =>
                  setState(() => _canContinue = value),
            ),
            PriceScreen(
              onContinueChanged: (value) =>
                  setState(() => _canContinue = value),
            ),
          ],
        ),
        footer: switch (_pageIndex) {
          0 => null,
          1 => _BottomActionButton(
            label: 'Check VIN',
            enabled: true,
            onPressed: _continueFromVin,
          ),
          _ => _BottomActionButton(
            label: 'Next',
            enabled: _canContinue,
            onPressed: _continue,
          ),
        },
      ),
    );
  }
}

class _BottomActionButton extends StatelessWidget {
  const _BottomActionButton({
    required this.label,
    required this.enabled,
    this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final Color background = enabled ? Colors.black : context.appSurface;
    final Color textColor = enabled ? Colors.white : const Color(0xFF6C6C6C);

    final double keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final double bottomGap = keyboardInset > 0 ? AppSpacing.md : 0;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomGap),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SizedBox(
          width: double.infinity,
          height: 61,
          child: ElevatedButton(
            onPressed: enabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              disabledBackgroundColor: background,
              backgroundColor: background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
            ),
            child: Text(
              label,
              style: AppTextStyles.button.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}

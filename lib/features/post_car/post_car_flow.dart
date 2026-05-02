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

  final PageController _pageController = PageController();
  int _activeStep = 0;
  int _pageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToPage(int pageIndex, {required int activeStep}) async {
    if (_pageIndex == pageIndex && _activeStep == activeStep) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _pageIndex = pageIndex;
      _activeStep = activeStep;
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

    _goToPage(0, activeStep: 0);
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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildAppTheme(brightness: Brightness.light),
      child: AppFlowScaffold(
        activeStep: _activeStep,
        totalSteps: 6,
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
            const VinCodeScreen(),
            const CarInfoScreen(),
          ],
        ),
        footer: switch (_pageIndex) {
          1 => AppPrimaryButton(
            label: 'Check VIN',
            onPressed: _continueFromVin,
          ),
          2 => AppPrimaryButton(label: 'Next', onPressed: () {}),
          _ => null,
        },
      ),
    );
  }
}

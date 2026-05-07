import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/post_car_screens.dart';
import 'package:image_picker/image_picker.dart';

class PostCarFlow extends StatefulWidget {
  const PostCarFlow({super.key});

  @override
  State<PostCarFlow> createState() => _PostCarFlowState();
}

class _PostCarFlowState extends State<PostCarFlow> {
  static const Duration _pageDuration = Duration(milliseconds: 280);
  static const Color _flowBackgroundColor = Colors.white;
  static const Color _flowSurfaceColor = Color(0xFFF5F5F5);
  static const double _bodyPadding = AppSpacing.lg;

  final PageController _pageController = PageController();
  int _activeStep = 0;
  int _pageIndex = 0;
  bool _canContinue = false;
  bool _canContinueUpdateScheduled = false;

  List<XFile> _uploadedImages = const <XFile>[];
  String? _selectedModel;
  int? _selectedYear;
  String? _selectedMakeLogoUrl;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _stepForPage(int pageIndex) {
    return switch (pageIndex) {
      0 => 0,
      1 || 2 => 1,
      3 => 2,
      4 => 3,
      5 => 4,
      6 => 5,
      7 => 6,
      8 => 7,
      9 => 8,
      _ => 0,
    };
  }

  Future<void> _goToPage(int pageIndex, {required int activeStep}) async {
    if (_pageIndex == pageIndex && _activeStep == activeStep) return;

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

  void _openVinLookup() => _goToPage(1, activeStep: 1);
  void _openManualEntry() => _goToPage(2, activeStep: 1);

  void _continue() {
    if (!_canContinue) return;
    final int nextPage = (_pageIndex + 1).clamp(0, 9);
    _goToPage(nextPage, activeStep: _stepForPage(nextPage));
  }

  void _setCanContinue(bool value) {
    if (!mounted) return;
    if (_canContinue == value) return;

    // Avoid setState during build from child initState/build notifications.
    if (_canContinueUpdateScheduled) return;
    _canContinueUpdateScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _canContinueUpdateScheduled = false;
      if (!mounted) return;
      if (_canContinue == value) return;
      setState(() => _canContinue = value);
    });
  }

  void _openPayment() => _goToPage(9, activeStep: _stepForPage(9));
  void _saveDraft() => Navigator.of(context).maybePop();

  void _pay() {
    if (!_canContinue) return;
    Navigator.of(context).maybePop();
  }

  void _openQrScannerBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: context.appOutlineSubtle,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'QR Scanner',
                style: AppTextStyles.sectionTitle.copyWith(
                  color: context.appTextPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Scanner placeholder. Integrate real VIN/QR scan later.',
                style: AppTextStyles.caption.copyWith(
                  color: context.appTextSecondary,
                ),
              ),
              const SizedBox(height: 16),
              AppSurface(
                height: 220,
                width: double.infinity,
                color: context.appSurface,
                borderRadius: AppRadius.card,
                child: Center(
                  child: Text(
                    'Camera preview',
                    style: AppTextStyles.value.copyWith(
                      color: context.appTextSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.button),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: AppTextStyles.button.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
        totalSteps: 9,
        backgroundColor: context.appBackground,
        onBack: _goBack,
        bodyHorizontalPadding: 0,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _bodyPadding),
              child: PostCarChoiceScreen(
                onEnterVinCode: _openVinLookup,
                onEnterCarManually: _openManualEntry,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _bodyPadding),
              child: VinCodeScreen(
                onContinueChanged: _setCanContinue,
                onScanVin: _openQrScannerBottomSheet,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _bodyPadding),
              child: CarInfoScreen(
                onContinueChanged: _setCanContinue,
                onVehicleChanged: (v) {
                  _selectedModel = v.model;
                  _selectedYear = v.year;
                  _selectedMakeLogoUrl = v.makeLogoUrl;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _bodyPadding),
              child: CarPicturesScreen(
                onContinueChanged: _setCanContinue,
                onImagesChanged: (images) => _uploadedImages = images,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _bodyPadding),
              child: CarPaintsScreen(onContinueChanged: _setCanContinue),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _bodyPadding),
              child: CarPlateScreen(onContinueChanged: _setCanContinue),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _bodyPadding),
              child: RegistrationLicenseScreen(
                onContinueChanged: _setCanContinue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _bodyPadding),
              child: PriceScreen(onContinueChanged: _setCanContinue),
            ),
            ReviewPostScreen(
              title:
                  '${_selectedModel ?? 'Model'} ${_selectedYear ?? DateTime.now().year}',
              location: 'Sulaymaniyah',
              timeLabel: 'Just now',
              coverImagePath: _uploadedImages.isEmpty
                  ? null
                  : _uploadedImages.first.path,
              makeLogoUrl: _selectedMakeLogoUrl,
            ),
            PaymentMethodsScreen(onContinueChanged: _setCanContinue),
          ],
        ),
        footer: switch (_pageIndex) {
          0 => null,
          1 => _BottomActionButton(
            label: 'Next',
            enabled: _canContinue,
            onPressed: _continue,
          ),
          8 => _ReviewFooter(onSaveDraft: _saveDraft, onPost: _openPayment),
          9 => _BottomActionButton(
            label: 'Pay',
            enabled: _canContinue,
            onPressed: _pay,
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

class _ReviewFooter extends StatelessWidget {
  const _ReviewFooter({required this.onSaveDraft, required this.onPost});

  final VoidCallback onSaveDraft;
  final VoidCallback onPost;

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final double bottomGap = keyboardInset > 0 ? AppSpacing.md : 0;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomGap),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 61,
                child: ElevatedButton(
                  onPressed: onSaveDraft,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.button),
                    ),
                  ),
                  child: Text(
                    'Save To Draft',
                    style: AppTextStyles.button.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SizedBox(
                height: 61,
                child: ElevatedButton(
                  onPressed: onPost,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.button),
                    ),
                  ),
                  child: Text(
                    'Post',
                    style: AppTextStyles.button.copyWith(color: Colors.white),
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

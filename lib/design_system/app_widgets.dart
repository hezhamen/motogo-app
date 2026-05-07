import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'app_design_system.dart';

const double _selectMenuGap = AppSpacing.sm;
const double _selectMenuVisibleItemCount = 4;
const double _selectMenuItemHeight = 48;

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: SizedBox(
        width: double.infinity,
        height: 61,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: context.appButtonPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.button.copyWith(
              color: context.appButtonOnPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class AppFlowScaffold extends StatelessWidget {
  const AppFlowScaffold({
    super.key,
    required this.activeStep,
    required this.body,
    this.footer,
    this.totalSteps = 3,
    this.backgroundColor,
    this.onBack,
    this.horizontalPadding = AppSpacing.lg,
    this.bodyHorizontalPadding,
  });

  final int activeStep;
  final int totalSteps;
  final Widget body;
  final Widget? footer;
  final Color? backgroundColor;
  final VoidCallback? onBack;
  final double horizontalPadding;
  final double? bodyHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    final double effectiveBodyPadding =
        bodyHorizontalPadding ?? horizontalPadding;
    final double keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      backgroundColor: backgroundColor ?? context.appBackground,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed:
                            onBack ?? () => Navigator.of(context).maybePop(),
                        icon: const Icon(Boxicons.bx_arrow_back, size: 18),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    OnboardingProgress(
                      activeStep: activeStep,
                      totalSteps: totalSteps,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: effectiveBodyPadding,
                  ),
                  child: body,
                ),
              ),
              if (footer != null) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.only(
                      bottom: keyboardInset > 0 ? AppSpacing.lg : 0,
                    ),
                    child: footer!,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AppSurface extends StatelessWidget {
  const AppSurface({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.padding,
    this.alignment,
    this.color,
    this.borderRadius = AppRadius.card,
    this.borderColor,
    this.clipBehavior = Clip.none,
  });

  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Color? color;
  final double borderRadius;
  final Color? borderColor;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: color ?? context.appSurface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: child,
    );
  }
}

class AppFormFieldCard extends StatefulWidget {
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
  State<AppFormFieldCard> createState() => _AppFormFieldCardState();
}

class _AppFormFieldCardState extends State<AppFormFieldCard> {
  final FocusScopeNode _scopeNode = FocusScopeNode();
  bool _hasFocus = false;

  @override
  void dispose() {
    _scopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Border? border = _hasFocus
        ? Border.all(color: context.appTextPrimary.withValues(alpha: 0.18))
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.label.copyWith(color: context.appTextSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        FocusScope(
          node: _scopeNode,
          onFocusChange: (hasFocus) {
            if (_hasFocus == hasFocus) return;
            setState(() => _hasFocus = hasFocus);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOutCubic,
            width: double.infinity,
            height: 61,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: context.appSurface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: border,
            ),
            alignment: Alignment.centerLeft,
            child: widget.child,
          ),
        ),
        if (widget.helper != null) ...[
          const SizedBox(height: AppSpacing.xs),
          widget.helper!,
        ],
      ],
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.style = AppTextStyles.value,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.hintText,
  });

  final String initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle style;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: style.copyWith(color: context.appTextPrimary),
      cursorColor: context.appTextPrimary,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: InputBorder.none,
        isCollapsed: true,
        hintText: hintText,
        hintStyle: style.copyWith(
          color: context.appTextPrimary.withValues(alpha: 0.35),
        ),
      ),
    );
  }
}

class AppOtpCell extends StatelessWidget {
  const AppOtpCell({
    super.key,
    required this.value,
    required this.isPlaceholder,
  });

  final String value;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      height: 61,
      alignment: Alignment.center,
      child: Text(
        value,
        style: AppTextStyles.otpDigit.copyWith(
          color: isPlaceholder
              ? context.appTextTertiary
              : context.appTextPrimary,
        ),
      ),
    );
  }
}

class AppBottomNavigationItem {
  const AppBottomNavigationItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
}

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.items,
    this.height,
    this.backgroundColor,
  });

  final List<AppBottomNavigationItem> items;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.paddingOf(context).bottom + 91,
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.appSurfaceRaised,
      ),
      child: Row(
        children: [
          for (final item in items) Expanded(child: _AppNavigationItem(item)),
        ],
      ),
    );
  }
}

class _AppNavigationItem extends StatelessWidget {
  const _AppNavigationItem(this.item);

  final AppBottomNavigationItem item;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = item.onTap == null;
    final Color iconColor = isDisabled
        ? context.appTextPrimary.withValues(alpha: 0.28)
        : item.isSelected
        ? context.appTextPrimary
        : context.appTextPrimary.withValues(alpha: 0.55);

    return Semantics(
      label: item.label,
      selected: item.isSelected && !isDisabled,
      button: !isDisabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.onTap,
          splashFactory: NoSplash.splashFactory,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 36,
                  child: Center(
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      scale: item.isSelected ? 1.05 : 1,
                      child: Icon(item.icon, size: 22, color: iconColor),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: iconColor,
                    fontSize: 11.5,
                    letterSpacing: item.isSelected ? -0.23 : -0.34,
                    fontWeight: item.isSelected
                        ? FontWeight.w600
                        : FontWeight.w400,
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

class AppSelectOption<T> {
  const AppSelectOption({required this.value, required this.label});

  final T value;
  final String label;
}

class AppSelectField<T> extends StatefulWidget {
  const AppSelectField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.placeholder,
  });

  final String label;
  final T? value;
  final List<AppSelectOption<T>> options;
  final ValueChanged<T> onChanged;
  final String? placeholder;

  @override
  State<AppSelectField<T>> createState() => _AppSelectFieldState<T>();
}

class _AppSelectFieldState<T> extends State<AppSelectField<T>> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  double _menuWidth = 0;
  double _menuMaxHeight = 0;
  bool _isOpen = false;
  bool _openAbove = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleMenu() {
    if (_isOpen) {
      _closeMenu();
      return;
    }

    final RenderBox? renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }

    final Offset fieldOffset = renderBox.localToGlobal(Offset.zero);
    final Size screenSize = MediaQuery.sizeOf(context);
    final EdgeInsets viewPadding = MediaQuery.paddingOf(context);
    final double fieldTop = fieldOffset.dy;
    final double fieldBottom = fieldTop + renderBox.size.height;
    final double menuHeight = _preferredMenuHeight(widget.options.length);
    final double spaceAbove = fieldTop - viewPadding.top;
    final double spaceBelow =
        screenSize.height - viewPadding.bottom - fieldBottom;
    final bool shouldOpenAbove =
        spaceBelow < menuHeight && spaceAbove > spaceBelow;
    final double availableHeight = shouldOpenAbove ? spaceAbove : spaceBelow;

    setState(() {
      _menuWidth = renderBox.size.width;
      _openAbove = shouldOpenAbove;
      _menuMaxHeight = availableHeight - _selectMenuGap;
      _isOpen = true;
    });
    _overlayController.show();
  }

  void _closeMenu() {
    if (!_isOpen) {
      return;
    }

    _overlayController.hide();
    setState(() {
      _isOpen = false;
    });
  }

  void _selectOption(T value) {
    widget.onChanged(value);
    _closeMenu();
  }

  double _preferredMenuHeight(int itemCount) {
    final double visibleItemCount = itemCount < _selectMenuVisibleItemCount
        ? itemCount.toDouble()
        : _selectMenuVisibleItemCount;

    return visibleItemCount * _selectMenuItemHeight +
        (visibleItemCount - 1) * AppSpacing.xs +
        AppSpacing.xs * 2;
  }

  @override
  Widget build(BuildContext context) {
    final AppSelectOption<T>? selectedOption = widget.value == null
        ? null
        : widget.options
              .where((option) => option.value == widget.value)
              .cast<AppSelectOption<T>?>()
              .firstWhere((_) => true, orElse: () => null);
    final String fieldLabel =
        selectedOption?.label ??
        widget.placeholder ??
        'Select ${widget.label.toLowerCase()}';
    final bool isPlaceholder = selectedOption == null;

    return OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeMenu,
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: _openAbove
                  ? Alignment.topLeft
                  : Alignment.bottomLeft,
              followerAnchor: _openAbove
                  ? Alignment.bottomLeft
                  : Alignment.topLeft,
              offset: Offset(0, _openAbove ? -_selectMenuGap : _selectMenuGap),
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: _menuWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.appSurface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: context.appOutlineSubtle),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: _menuMaxHeight > 0
                              ? _menuMaxHeight
                              : _preferredMenuHeight(widget.options.length),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (
                                int index = 0;
                                index < widget.options.length;
                                index++
                              )
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index == widget.options.length - 1
                                        ? 0
                                        : AppSpacing.xs,
                                  ),
                                  child: _SelectMenuItem(
                                    label: widget.options[index].label,
                                    isSelected:
                                        widget.options[index].value ==
                                        widget.value,
                                    onTap: () => _selectOption(
                                      widget.options[index].value,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          key: _fieldKey,
          onTap: _toggleMenu,
          behavior: HitTestBehavior.opaque,
          child: AppFormFieldCard(
            label: widget.label,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fieldLabel,
                    style: AppTextStyles.value.copyWith(
                      color: isPlaceholder
                          ? context.appTextPrimary.withValues(alpha: 0.45)
                          : context.appTextPrimary,
                    ),
                  ),
                ),
                Icon(
                  _isOpen ? Boxicons.bx_chevron_up : Boxicons.bx_chevron_down,
                  size: 18,
                  color: context.appTextPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectMenuItem extends StatelessWidget {
  const _SelectMenuItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? context.appSurfaceRaised : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.card - 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card - 4),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 15,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.value.copyWith(
                    color: context.appTextPrimary,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Boxicons.bx_check,
                  size: 16,
                  color: context.appTextPrimary,
                ),
            ],
          ),
        ),
      ),
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
            color: isActive ? context.appTextPrimary : context.appTextTertiary,
          ),
        );
      }),
    );
  }
}

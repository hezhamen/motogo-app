import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
        ),
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
        if (helper != null) ...[const SizedBox(height: AppSpacing.xs), helper!],
      ],
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
  });

  final String label;
  final T value;
  final List<AppSelectOption<T>> options;
  final ValueChanged<T> onChanged;

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
    final AppSelectOption<T> selectedOption = widget.options.firstWhere(
      (option) => option.value == widget.value,
    );

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
                      color: AppColors.surfaceField,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.outlineSubtle),
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
                  child: Text(selectedOption.label, style: AppTextStyles.value),
                ),
                Icon(
                  _isOpen ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                  size: 18,
                  color: AppColors.textPrimary,
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
      color: isSelected ? const Color(0xFFFFFFFF) : Colors.transparent,
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
              Expanded(child: Text(label, style: AppTextStyles.value)),
              if (isSelected)
                const Icon(
                  LucideIcons.check,
                  size: 16,
                  color: AppColors.textPrimary,
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
            color: isActive
                ? AppColors.progressActive
                : AppColors.progressInactive,
          ),
        );
      }),
    );
  }
}

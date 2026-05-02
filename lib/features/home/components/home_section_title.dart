import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.value.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.42,
      ),
    );
  }
}

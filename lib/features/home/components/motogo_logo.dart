import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_design_system.dart';

class MotogoLogo extends StatelessWidget {
  const MotogoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle logoStyle = TextStyle(
      fontFamily: 'Inter',
      fontSize: 20,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.2,
      height: 1,
    );

    return RichText(
      text: const TextSpan(
        style: logoStyle,
        children: [
          TextSpan(
            text: 'MOTO',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          TextSpan(
            text: 'GO',
            style: TextStyle(color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

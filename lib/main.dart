import 'package:flutter/material.dart';

import 'design_system/app_design_system.dart';
import 'features/onboarding/onboarding_flow.dart';

void main() {
  runApp(const MotogoApp());
}

class MotogoApp extends StatelessWidget {
  const MotogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motogo',
      theme: buildAppTheme(),
      home: const OnboardingFlow(),
    );
  }
}

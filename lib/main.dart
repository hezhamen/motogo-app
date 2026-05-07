import 'package:flutter/material.dart';

import 'design_system/app_design_system.dart';
import 'app_shell.dart';

void main() {
  runApp(const MotogoApp());
}

class MotogoApp extends StatefulWidget {
  const MotogoApp({super.key});

  @override
  State<MotogoApp> createState() => _MotogoAppState();
}

class _MotogoAppState extends State<MotogoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motogo',
      theme: buildAppTheme(brightness: Brightness.light),
      home: const AppShell(),
    );
  }
}

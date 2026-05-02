import 'package:flutter/material.dart';

import 'design_system/app_design_system.dart';
import 'features/home/home_screen.dart';

void main() {
  runApp(const MotogoApp());
}

class MotogoApp extends StatefulWidget {
  const MotogoApp({super.key});

  @override
  State<MotogoApp> createState() => _MotogoAppState();
}

class _MotogoAppState extends State<MotogoApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _setThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motogo',
      theme: buildAppTheme(brightness: Brightness.light),
      darkTheme: buildAppTheme(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: HomeScreen(onThemeModeChanged: _setThemeMode),
    );
  }
}

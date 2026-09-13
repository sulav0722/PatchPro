import 'package:flutter/material.dart';
import 'screens/startup_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const PatchProApp());
}

class PatchProApp extends StatelessWidget {
  const PatchProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PatchPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.rubyMid,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.rubyLight,
          secondary: AppColors.rubyMid,
          surface: AppColors.surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
      ),
      // Back to the normal flow
      home: const StartupScreen(),
    );
  }
}
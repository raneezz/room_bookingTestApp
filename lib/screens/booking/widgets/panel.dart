import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AppPanel extends StatelessWidget {
  final Widget child;

  const AppPanel({super.key, required this.child});

  @override
  Widget build(BuildContext c) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: AppColors.panel,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: AppColors.border),
    ),
    child: child,
  );
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class GoldPill extends StatelessWidget {
  final String text;

  const GoldPill({super.key, required this.text});

  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: const Color(0xFF33260D),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFF805A10)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.gold,
        fontSize: 11,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class RoomCodePill extends StatelessWidget {
  final String text;

  const RoomCodePill({super.key, required this.text});

  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xCC1C2027),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.gold,
        fontSize: 11,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/BookingController.dart';


class ConfirmBar extends StatelessWidget {
  final BookingController controller;

  const ConfirmBar({super.key, required this.controller});

  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.fromLTRB(22, 14, 22, 20),
    decoration: const BoxDecoration(
      color: AppColors.background,
      border: Border(top: BorderSide(color: Color(0xFF172131))),
    ),
    child: SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: controller.confirmReservation,
        icon: const Icon(Icons.check_rounded, color: Colors.black),
        label: const Text(
          'Confirm Reservation',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          elevation: 7,
        ),
      ),
    ),
  );
}

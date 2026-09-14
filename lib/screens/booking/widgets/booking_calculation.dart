import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roombookingapp/screens/booking/widgets/panel.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../controllers/BookingController.dart';

class BookingCalculation extends StatelessWidget {
  final BookingController controller;

  const BookingCalculation({super.key, required this.controller});

  @override
  Widget build(BuildContext c) => Obx(
    () => AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'BOOKING CALCULATION',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              if (controller.selectedRoom != null)
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF253149),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${controller.selectedRoom!.type} (${controller.selectedRoom!.code})',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFFD5DDEC),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF202C40), height: 1),
          const SizedBox(height: 15),
          _Row(
            label: controller.selectedRoom == null
                ? 'Nights × price'
                : '${controller.nights} Nights × ${CurrencyUtils.formatRupees(controller.selectedRoom!.pricePerNight)}',
            value: controller.subtotal == 0
                ? '—'
                : CurrencyUtils.formatRupees(controller.subtotal),
          ),
          const SizedBox(height: 10),
          _Row(
            label: 'Duration',
            value: controller.nights == 0
                ? '—'
                : '${controller.nights} ${controller.nights == 1 ? 'Night' : 'Nights'}',
          ),
          const SizedBox(height: 10),
          _Row(
            label: 'Guests Capacity',
            value: controller.selectedRoom == null
                ? '${controller.totalGuests} Guests'
                : '${controller.totalGuests} Guests (Max ${controller.selectedRoom!.maxGuests})',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(color: Color(0xFF202C40), height: 1),
          ),
          Row(
            children: [
              const Text(
                'Total Final Price',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                controller.subtotal == 0
                    ? '₹0'
                    : CurrencyUtils.formatRupees(controller.subtotal),
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Nights × price per night • taxes not included',
            style: TextStyle(
              color: AppColors.green,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

class _Row extends StatelessWidget {
  final String label, value;

  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext c) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: const TextStyle(color: Color(0xFFB4C0D2), fontSize: 14),
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Color(0xFFD9DFEA),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

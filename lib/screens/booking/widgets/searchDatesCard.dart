import 'package:flutter/material.dart' hide DateUtils;
import 'package:get/get.dart';
import 'package:roombookingapp/screens/booking/widgets/panel.dart';
import 'package:roombookingapp/screens/booking/widgets/pills.dart';
import 'package:roombookingapp/screens/booking/widgets/validation_banner.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_utils.dart';
import '../controllers/BookingController.dart';
import 'guest_counter.dart';

class SearchDatesCard extends StatelessWidget {
  final BookingController controller;

  const SearchDatesCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) => AppPanel(
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: AppColors.gold,
                size: 19,
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'SELECT STAY DATES',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (controller.nights > 0)
                GoldPill(text: '${controller.nights} Nights'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _DateField(
                  label: 'Check-in Date',
                  value: DateUtils.formatDate(controller.checkIn.value),
                  onTap: () => controller.pickCheckIn(context),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _DateField(
                  label: 'Check-out Date',
                  value: DateUtils.formatDate(controller.checkOut.value),
                  onTap: () => controller.pickCheckOut(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFF202C40), height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GuestCounter(
                  title: 'Adults',
                  subtitle: 'Age 13+',
                  value: controller.adults.value,
                  onMinus: controller.decrementAdults,
                  onPlus: controller.incrementAdults,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: GuestCounter(
                  title: 'Kids',
                  subtitle: 'Under 12',
                  value: controller.kids.value,
                  onMinus: controller.decrementKids,
                  onPlus: controller.incrementKids,
                ),
              ),
            ],
          ),
          if (controller.validationMessage.value != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ValidationBanner(
                message: controller.validationMessage.value!,
                isError: controller.validationIsError.value,
              ),
            ),
        ],
      ),
    ),
  );
}

class _DateField extends StatelessWidget {
  final String label, value;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext c) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(17),
    child: Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value.isEmpty ? 'Select date' : value,
            style: TextStyle(
              color: value.isEmpty ? const Color(0xFF687790) : Colors.white,
              fontSize: 12,
              fontWeight: value.isEmpty ? FontWeight.w400 : FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}

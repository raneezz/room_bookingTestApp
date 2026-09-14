import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roombookingapp/screens/booking/widgets/pills.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../data/models/hotel_room.dart';
import '../controllers/BookingController.dart';


class RoomCard extends StatelessWidget {
  final HotelRoom room;
  final BookingController controller;

  const RoomCard({
    super.key,
    required this.room,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasDates = controller.checkIn.value != null &&
          controller.checkOut.value != null &&
          controller.datesAreValid;

      final booked = hasDates && controller.isRoomBooked(room);
      final capacityExceeded = !controller.roomFitsGuests(room);
      final selected = controller.selectedRoomCode.value == room.code;
      final disabled = booked || capacityExceeded;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: selected ? AppColors.orange : const Color(0xFF1D2A40),
            width: selected ? 2.5 : 2,
          ),
        ),
        child: InkWell(
          onTap: disabled ? null : () => controller.selectRoom(room),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoomImage(
                  room: room,
                  disabled: disabled,
                  statusText: capacityExceeded ? 'UNAVAILABLE' : 'BOOKED',
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: SizedBox(
                    height: 122,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            RoomCodePill(text: room.code),
                            const Spacer(),
                            SelectionIndicator(
                              selected: selected,
                              disabled: disabled,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          room.type,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: disabled
                                ? const Color(0xFF556175)
                                : const Color(0xFFAAB8CC),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          room.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: disabled
                              ? const Color(0xFF67748A)
                                : const Color(0xFFAAB8CC),
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        const Divider(
                          color: Color(0xFF202C40),
                          height: 1,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.person_outline,
                              color: Color(0xFF8798B2),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'Max ${room.maxGuests}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF9AA8BF),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              CurrencyUtils.formatRupees(
                                room.pricePerNight,
                              ),
                              style: TextStyle(
                                color: disabled
                                    ? const Color(0xFF67748A)
                                    : const Color(0xFFAAB8CC),
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Text(
                              ' /night',
                              style: TextStyle(
                                color: Color(0xFF728097),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class RoomImage extends StatelessWidget {
  final HotelRoom room;
  final bool disabled;
  final String statusText;

  const RoomImage({
    super.key,
    required this.room,
    required this.disabled,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Opacity(
            opacity: disabled ? .42 : 1,
            child: Image.asset(
              room.imageAsset,
              width: 135,
              height: 112,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 135,
                height: 112,
                color: const Color(0xFF263143),
                child: const Icon(
                  Icons.hotel_rounded,
                  size: 45,
                  color: AppColors.gold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 9,
          top: 9,
          child: RoomCodePill(text: room.code),
        ),
        if (room.badge != null)
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: room.badge == 'LUXE'
                    ? AppColors.orange
                    : const Color(0xFF00B987),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                room.badge!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        if (disabled)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .32),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xCC121A2A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusText,
                    style: const TextStyle(
                      color: Color(0xFFFFC04A),
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class SelectionIndicator extends StatelessWidget {
  final bool selected;
  final bool disabled;

  const SelectionIndicator({
    super.key,
    required this.selected,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: selected ? AppColors.orange : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected
              ? AppColors.orange
              : disabled
                  ? const Color(0xFF3B465A)
                  : const Color(0xFF52627A),
          width: 2.5,
        ),
      ),
      child: selected
          ? const Icon(Icons.check, size: 18, color: Colors.black)
          : null,
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/hotel_room.dart';
import '../controllers/BookingController.dart';

import 'room_card.dart';

class RoomSection extends StatelessWidget {
  final BookingController controller;

  const RoomSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.apartment_outlined,
              color: AppColors.gold,
              size: 20,
            ),
            const SizedBox(width: 9),
            const Expanded(
              child: Text(
                'STEP 2: CHOOSE ROOM',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              '${controller.rooms.length} Rooms in table',
              style: const TextStyle(
                color: Color(0xFF8F9EB7),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),

        // RoomCard contains its own Obx because each card depends on
        // reactive booking state.
        ...controller.rooms.map(
          (HotelRoom room) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: RoomCard(
              room: room,
              controller: controller,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/BookingController.dart';
import '../widgets/booking_calculation.dart';
import '../widgets/confirm_bar.dart';
import '../widgets/room_section.dart';
import '../widgets/searchDatesCard.dart';
import '../widgets/top_bar.dart';

class BookingPage extends GetView<BookingController> {
  const BookingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SearchDatesCard(controller: controller),
                          const SizedBox(height: 28),
                          RoomSection(controller: controller),
                          const SizedBox(height: 24),

                          Obx(
                                () =>
                            controller.selectedRoom != null
                                ? BookingCalculation(controller: controller)
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ConfirmBar(controller: controller),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/BookingController.dart';
import '../widgets/searchDatesCard.dart';
import '../widgets/top_bar.dart';

class BookingPage extends GetView<BookingController> {
  const BookingPage({super.key});

  @override Widget build(BuildContext context) =>
    Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    sliver: SliverList(delegate: SliverChildListDelegate([
                      SearchDatesCard(controller: controller),
                    ])),
                  ),

                ],
              ),

            ),
          ],
        ),
      ),
    );
  }


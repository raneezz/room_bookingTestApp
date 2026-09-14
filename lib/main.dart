import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:roombookingapp/screens/booking/controllers/BookingController.dart';
import 'package:roombookingapp/screens/booking/pages/BookingPage.dart';

import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
      GetMaterialApp(debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        title: 'Booking App',
        initialBinding: BookingBinding(),
        home: const BookingPage(),);
}

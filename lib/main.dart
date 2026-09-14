import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:roombookingapp/screens/booking/controllers/BookingController.dart';
import 'package:roombookingapp/screens/booking/pages/BookingPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>

      GetMaterialApp(debugShowCheckedModeBanner: false,
        title: 'Booking App',
        initialBinding: BindingsBuilder(() => Get.put(BookingController())),
        home: const BookingPage(),);
}

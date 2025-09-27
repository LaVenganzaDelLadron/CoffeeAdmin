import 'package:admincoffee/controller/add_product_controller.dart';
import 'package:admincoffee/controller/auth_controller.dart';
import 'package:admincoffee/controller/get_product_count_controller.dart';
import 'package:admincoffee/view/onboardingscreen/onboardingscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(GetProductCountController());
  Get.put(AuthController());
  Get.put(AddProductController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const OnboardingPage(),
    );
  }
}

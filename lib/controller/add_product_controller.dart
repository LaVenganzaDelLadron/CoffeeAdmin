import 'dart:io';
import 'package:admincoffee/services/api_add_coffee.dart';
import 'package:admincoffee/utils/debug_logger.dart';
import 'package:get/get.dart';


class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  Future<void> addProduct(
    String name,
    String description,
    String category,
    double price,
    String aid,
    File imageFile,
  ) async {
    DebugLogger.debug("Adding product → name=$name, desc=$description, "
        "category=$category, price=$price, aid=$aid, imagePath=${imageFile.path}");

    try {
      final result = await ApiAddCoffee.addCoffee(
        name,
        description,
        category,
        price,
        aid,
        imageFile.path,
      );

      DebugLogger.info("API Response: $result");

      if (result["coffee_id"] != null) {
        DebugLogger.info("✅ Product Added Successfully → Coffee ID: ${result["coffee_id"]}");
      } else {
        DebugLogger.warn("⚠️ Failed to add product → $result");
      }
    } catch (e, stack) {
      DebugLogger.error("❌ Error Adding Product", e, stack);
    }
  }
}

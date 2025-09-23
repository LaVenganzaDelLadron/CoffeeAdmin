import 'dart:io';
import 'package:admincoffee/services/api_add_coffee.dart';
import 'package:admincoffee/view/dialog/show_alert_dialog.dart';
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
    print("[DEBUG] Adding product → "
        "name=$name, desc=$description, category=$category, price=$price, aid=$aid, "
        "imagePath=${imageFile.path}");

    try {
      final result = await ApiAddCoffee.addCoffee(
        name,
        description,
        category,
        price,
        aid,
        imageFile,
      );

      print("[DEBUG] API Response: $result");

      if (result["coffee_id"] != null) {
        print("[DEBUG] Product Added Successfully → Coffee ID: ${result["coffee_id"]}");

        showAuthDialog(
          title: "Product Added",
          message: "Product $name added successfully",
          isSuccess: true,
        );
      } else {
        print("[DEBUG] Failed to add product");

        showAuthDialog(
          title: "Failed to add product",
          message: "Please try again",
          isSuccess: false,
        );
      }
    } catch (e) {
      print("[DEBUG] Error Adding Product: $e");

      showAuthDialog(
        title: "Error",
        message: "Something went wrong $e",
        isSuccess: false,
      );
    }
  }
}

import 'dart:typed_data';
import 'package:admincoffee/model/coffee.dart';
import 'package:admincoffee/services/api_coffee_services.dart';
import 'package:get/get.dart';

class GetProductController extends GetxController {
  static GetProductController get instance => Get.find();

  Future<List<Coffee>> fetchAllProducts(String aid) async {
    try {
      final result = await ApiCoffeeServices.getAllProduct(aid);

      // result is a List<dynamic>, so map to Coffee
      return (result).map((json) {
        return Coffee.fromJson(json as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}

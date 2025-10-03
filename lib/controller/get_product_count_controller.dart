import 'package:admincoffee/services/api_coffee_services.dart';
import 'package:admincoffee/utils/debug_logger.dart';
import 'package:get/get.dart';


class GetProductCountController extends GetxController {
  static GetProductCountController get instance => Get.find();


  Future<int> fetchProductCount(String aid) async {
    DebugLogger.debug("Fetching product count from API");
    try {
      final result = await ApiCoffeeServices.getProductCount(aid);

      DebugLogger.info("API Response: $result");

      if (result["count"] != null) {
        int count = result["count"];
        DebugLogger.info("✅ Product Count Fetched Successfully → Count: $count");
        return count;
      } else {
        DebugLogger.warn("⚠️ Failed to fetch product count → $result");
        return 0;
      }
    } catch (e, stack) {
      DebugLogger.error("❌ Error Fetching Product Count", e, stack);
      return 0;
    }
  }
}

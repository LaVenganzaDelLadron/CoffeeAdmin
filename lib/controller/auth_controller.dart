import 'package:admincoffee/services/api_auth_services.dart';
import 'package:admincoffee/view/dialog/show_alert_dialog.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  void login(String email, String password) async {
    try {
      final result = await ApiAuthServices.loginUser(email, password);

      if (result["user_id"] != null) {
        showAuthDialog(title: "Login Successfull",
        message: "Welcoe Back, ${email}",
        isSuccess: true,
        );
      } else {
        showAuthDialog(title: "Login Failed",
        message: "Invalid Credentials",
        isSuccess: false,
        );
      }
    } catch (e) {
      showAuthDialog(title: "Error",
        message: "Something went wrong ${e}",
        isSuccess: false,
        );
    }
  }
}

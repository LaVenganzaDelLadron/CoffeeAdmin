import 'package:admincoffee/services/api_auth_services.dart';
import 'package:admincoffee/view/dialog/show_alert_dialog.dart';
import 'package:get/get.dart';

class Admin {
  final String id;
  final String email;

  Admin({required this.id, required this.email});
}

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  var currentAdmin = Rxn<Admin>();

  Future<void> login(String email, String password) async {
    try {
      final result = await ApiAuthServices.loginUser(email, password);

      if (result["user_id"] != null) {
        currentAdmin.value =
            Admin(id: result["user_id"].toString(), email: email);

        showAuthDialog(
          title: "Login Successful",
          message: "Welcome Back, $email",
          isSuccess: true,
        );
      } else {
        showAuthDialog(
          title: "Login Failed",
          message: "Invalid Credentials",
          isSuccess: false,
        );
      }
    } catch (e) {
      showAuthDialog(
        title: "Error",
        message: "Something went wrong $e",
        isSuccess: false,
      );
    }
  }
}

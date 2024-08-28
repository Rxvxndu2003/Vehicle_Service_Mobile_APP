import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = 'name'.obs;
  var userEmail = 'email'.obs;

  void setUserName(String name) {
    userName.value = name;
  }

  void setUserEmail(String email) {
    userEmail.value = email;
  }
}

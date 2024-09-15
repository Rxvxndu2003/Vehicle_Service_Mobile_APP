import 'package:get/get.dart';

class UserController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;

  void setUserName(String name) {
    this.name.value = name;
  }

  void setUserEmail(String email) {
    this.email.value = email;
  }
}

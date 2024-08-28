import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_app/controllers/theme_controller.dart';
import 'package:vehicle_app/controllers/user_controller.dart';
import 'package:vehicle_app/screens/add_vehicle.dart';
import 'package:vehicle_app/screens/book_now.dart';
import 'package:vehicle_app/screens/home_screen.dart';
import 'package:vehicle_app/screens/login_screen.dart';
import 'package:vehicle_app/screens/menue_screen.dart';
import 'package:vehicle_app/screens/products_screen.dart';
import 'package:vehicle_app/screens/schedule_screen.dart';
import 'package:vehicle_app/screens/service_screen.dart';
import 'package:vehicle_app/screens/signup_screen.dart';
import 'package:vehicle_app/screens/splash_screen.dart';
import 'package:vehicle_app/screens/welcome_screen.dart';
import 'package:vehicle_app/theme/theme.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final ThemeController themeController = Get.put(ThemeController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'My App',
        initialRoute: '/', // Define the initial route
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: SplashScreen(),
        getPages: [
          // Define your routes here
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/home', page: () => NavbarRoots()),
          GetPage(name: '/signup', page: () => SignUpScreen()),
          GetPage(name: '/addVehicle', page: () => AddVehicle()),
          GetPage(name: '/bookNow', page: () => BookNow()),
          GetPage(name: '/schedule', page: () => ScheduleScreen()),
          GetPage(name: '/service', page: () => ServiceScreen()),
          GetPage(name: '/welcome', page: () => WelcomeScreen()),
        ],
      );
    });
  }
}

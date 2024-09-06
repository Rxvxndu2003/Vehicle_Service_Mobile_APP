import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_app/controllers/theme_controller.dart';
import 'package:vehicle_app/controllers/user_controller.dart';
import 'package:vehicle_app/screens/add_vehicle.dart';
import 'package:vehicle_app/screens/book_now.dart';
import 'package:vehicle_app/screens/login_screen.dart';
import 'package:vehicle_app/screens/schedule_screen.dart';
import 'package:vehicle_app/screens/service_screen.dart';
import 'package:vehicle_app/screens/signup_screen.dart';
import 'package:vehicle_app/screens/splash_screen.dart';
import 'package:vehicle_app/screens/welcome_screen.dart';
import 'package:vehicle_app/theme/theme.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final ThemeController themeController = Get.put(ThemeController());
  final UserController userController = Get.put(UserController());

   MyApp({super.key});

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
        home: const SplashScreen(),
        getPages: [
          // Define your routes here
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/home', page: () => const NavbarRoots()),
          GetPage(name: '/signup', page: () => const SignUpScreen()),
          GetPage(name: '/addVehicle', page: () => const AddVehicle()),
          GetPage(name: '/bookNow', page: () => const BookNow()),
          GetPage(name: '/schedule', page: () => const ScheduleScreen()),
          GetPage(name: '/service', page: () => const ServiceScreen()),
          GetPage(name: '/welcome', page: () => const WelcomeScreen()),
        ],
      );
    });
  }
}



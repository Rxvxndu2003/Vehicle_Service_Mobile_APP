import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_app/controllers/theme_controller.dart';
import 'package:vehicle_app/screens/dark_screen.dart';
import 'package:vehicle_app/screens/login_screen.dart';


class DarkScreen extends StatefulWidget {
  @override
  State<DarkScreen> createState() => _DarkScreenState();
}

class _DarkScreenState extends State<DarkScreen> {
   bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Obx(() {
              return Icon(
                themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
              );
            }),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'Schedule service,\n track progress, pay with ease.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your cars digital service companion, providing effortless scheduling.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            
            Image.asset(
              'images/service3.png', // Replace with your image path
              height: 300,
            ),
            Spacer(),
               Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(width: 10),
                          Text('Notifications'),
                        ],
                      ),
                      Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeController.isDarkMode.value
                          ? Color(0xFFFFD700)
                          : Color(0xFFFFD700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 16,
                       color: Colors.black87
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


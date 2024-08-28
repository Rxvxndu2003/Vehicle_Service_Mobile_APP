import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_app/Services/camera_service.dart';
import 'package:vehicle_app/Services/geolocation_Service.dart';
import 'package:vehicle_app/Services/lightsensor_service.dart';
import 'package:vehicle_app/controllers/theme_controller.dart';
import 'package:vehicle_app/controllers/user_controller.dart';
import 'package:vehicle_app/screens/ConnectivityStatusScreenState.dart';
import 'package:vehicle_app/screens/about_screen.dart';
import 'package:vehicle_app/screens/login_screen.dart';
import 'package:vehicle_app/screens/privacy_screen.dart';
import 'package:vehicle_app/screens/profile_detail_page.dart';
import 'package:vehicle_app/widgets/battery_status.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';
import 'package:vehicle_app/widgets/vehicle_list.dart';

class MenueScreen extends StatefulWidget {
  @override
  State<MenueScreen> createState() => _MenueScreenState();
}

class _MenueScreenState extends State<MenueScreen> {
  final ThemeController themeController = Get.find();
  final UserController userController = Get.find();

  void _logout() {
    // Clear user session data here, if any
    userController.setUserName('');

    // Show logout success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully logged out'),
      ),
    );

    // Navigate to the login screen and remove all previous routes after a short delay
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavbarRoots()),
                      );
                    },
                    child: Text(
                      'Menu',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('images/person.jpeg'),
                    ),
                    title: Obx(() {
                      return Text(
                        userController.userName.value.isNotEmpty
                          ? userController.userName.value
                          : "Guest",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      );
                    }),
                    subtitle: Text(
                      "Profile",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Divider(height: 50),
                  Obx(() {
                    return SwitchListTile(
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      secondary: Icon(
                        themeController.isDarkMode.value
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        size: 35,
                        color: Color.fromARGB(255, 255, 196, 0),
                      ),
                      value: themeController.isDarkMode.value,
                      onChanged: (value) {
                        themeController.toggleTheme();
                      },
                    );
                  }),
                  SizedBox(height: 20),
                  buildMenuItem(
                    icon: CupertinoIcons.person,
                    text: "Profile",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileDetailPage(),
                      ));
                    },
                  ),
                  SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.signal_cellular_0_bar_sharp,
                    text: "Network",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ConnectivityStatusScreen() ,
                      ));
                    },
                  ),
                  SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.car_rental_sharp,
                    text: "Vehicle List",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => VehicleListPage() ,
                      ));
                    },
                  ),
                  SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.notifications_none_outlined,
                    text: "Notifications",
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    text: "Privacy",
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PrivacyPage() ,
                      ));
                    },
                  ),
                  SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.settings_suggest_outlined,
                    text: "General",
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.info_outline_rounded,
                    text: "About Us",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AboutScreen() ,
                      ));
                    },
                  ),
                  Divider(height: 40),
                  buildMenuItem(
                    icon: Icons.logout,
                    text: "Log Out",
                    onTap: _logout,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildMenuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 196, 0),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: 35,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}

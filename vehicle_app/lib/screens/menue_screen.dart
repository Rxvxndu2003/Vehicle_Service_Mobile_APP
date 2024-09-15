import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:vehicle_app/Services/battery_service.dart';
import 'package:vehicle_app/controllers/theme_controller.dart';
import 'package:vehicle_app/controllers/user_controller.dart';
import 'package:vehicle_app/screens/ConnectivityStatusScreenState.dart';
import 'package:vehicle_app/screens/Preferences_screen.dart';
import 'package:vehicle_app/screens/about_screen.dart';
import 'package:vehicle_app/screens/contactUs_screen.dart';
import 'package:vehicle_app/screens/faq_screen.dart';
import 'package:vehicle_app/screens/login_screen.dart';
import 'package:vehicle_app/screens/privacy_screen.dart';
import 'package:vehicle_app/screens/profile_detail_page.dart';
import 'package:vehicle_app/screens/qr_scanner.dart';
import 'package:vehicle_app/screens/service_screen.dart';
import 'package:vehicle_app/screens/vehicles_screen.dart';
import 'package:vehicle_app/widgets/vehicle_list.dart';
import 'package:vehicle_app/screens/location_screen.dart';

class MenueScreen extends StatefulWidget {
  const MenueScreen({super.key});

  @override
  State<MenueScreen> createState() => _MenueScreenState();
}

class _MenueScreenState extends State<MenueScreen> {
  final ThemeController themeController = Get.find();
  final UserController userController = Get.find();

  void _logout() {
    // Clear user session data here, if any
    userController.setUserName('');
    userController.setUserEmail('');

    // Show logout success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully logged out'),
      ),
    );

    // Navigate to the login screen and remove all previous routes after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Image.asset(
          'images/wordlogo.png',
           height: 130,
           fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,
            color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              // Add functionality for the search button here
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined,
            color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              // Add functionality for notifications
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only( top: 20,left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('images/person.jpeg'),
                ),
                title: Obx(() {
                  return Text(
                    userController.name.value.isNotEmpty
                        ? userController.name.value
                        : "Guest",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  );
                }),
                subtitle: Obx(() {
                  return Text(
                    userController.email.value.isNotEmpty
                        ? userController.email.value
                        : "No email",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  );
                }),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileDetailPage(),
                        ),
                      );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Upgrade Section
              Container(
                height: 200,
  padding: const EdgeInsets.all(15),
  decoration: BoxDecoration(
    image: const DecorationImage(
      image: AssetImage('images/mustang.jpg'), // Replace with your image path
      fit: BoxFit.cover, // Ensures the image covers the entire container
    ),
    gradient: LinearGradient(
      colors: [
        Colors.black.withOpacity(1.0),
        Colors.black.withOpacity(0.2),
      ], // Adjust gradient colors as needed
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Starter Plan",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "All features unlocked!",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
      ElevatedButton(
        onPressed: () {
          // Handle upgrade action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple,
        ),
        child: const Text("Upgrade"),
      ),
    ],
  ),
),

              const SizedBox(height: 30),

              // Account Section
              const Text("Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              buildMenuItem(
                icon: CupertinoIcons.car_fill,
                text: "Vehicles",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const VehiclesScreen() ,
                      ));
                },
              ),
              buildMenuItem(
                icon: Icons.phone_android,
                text: "Scan",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const QrScanner() ,
                      ));
                },
              ),
              buildMenuItem(
                icon: CupertinoIcons.location_solid,
                text: "Addresses",
                onTap: () {},
              ),
              buildMenuItem(
                icon: Icons.privacy_tip_sharp,
                text: "Privacy",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const PrivacyPage() ,
                      ));
                },
              ),
              buildMenuItem(
                icon: CupertinoIcons.info_circle_fill,
                text: "About Us",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AboutScreen() ,
                      ));
                },
              ),
              const Text("Personalization", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              buildMenuItem(
                icon: CupertinoIcons.bell,
                text: "Notification",
                onTap: () {},
              ),
              buildMenuItem(
                icon: CupertinoIcons.settings,
                text: "Preferences",
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CookiePreferencesScreen() ,
                      ));
                },
              ),
              const Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              buildMenuItem(
                icon: CupertinoIcons.globe,
                text: "Network",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ConnectivityStatusScreen() ,
                      ));
                },
              ),
              buildMenuItem(
                icon: CupertinoIcons.location,
                text: "Location",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const LocationPage() ,
                      ));
                },
              ),
              buildMenuItem(
                icon: CupertinoIcons.battery_charging,
                text: "Battery",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                        builder: (context) => BatteryStatusScreen() ,
                      ));
                },
              ),
              const Text("Help & Support", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              buildMenuItem(
                icon: CupertinoIcons.phone,
                text: "Get Help",
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ContactUsScreen() ,
                      ));
                },
              ),
              buildMenuItem(
                icon: CupertinoIcons.question_circle,
                text: "FAQ",
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(
                        builder: (context) => FAQScreen(),
                      ));
                },
              ),
              const Divider(height: 40),
              buildMenuItem(
                icon: CupertinoIcons.arrow_left_circle,
                text: "Log Out",
                onTap: _logout,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 25,
      color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing:  Icon(Icons.arrow_forward_ios_rounded, size: 20,
      color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
      ),
    );
  }
}

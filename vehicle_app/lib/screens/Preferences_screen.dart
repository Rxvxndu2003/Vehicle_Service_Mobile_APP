import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_app/controllers/theme_controller.dart';
import 'package:vehicle_app/screens/menue_screen.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';

class CookiePreferencesScreen extends StatefulWidget {
  @override
  _CookiePreferencesScreenState createState() =>
      _CookiePreferencesScreenState();
}

class _CookiePreferencesScreenState extends State<CookiePreferencesScreen> {
  final ThemeController themeController = Get.find();
  bool analyticsSwitch = false;
  bool personalizationSwitch = false;
  bool marketingSwitch = false;
  bool socialMediaSwitch = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Preferences'),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavbarRoots(initialIndex: 4,)),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Reset logic to default values
              setState(() {
                analyticsSwitch = false;
                personalizationSwitch = false;
                marketingSwitch = false;
                socialMediaSwitch = false;
              });
            },
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Obx(() {
            return _buildSwitchTile(
              'Dark Mode',
              'Toggle between dark and light mode for the application. Make your application more better.',
              themeController.isDarkMode.value,
              (value) {
                themeController.toggleTheme();
              },
            );
          }),
          _buildSwitchTile(
            'Analytics',
            'Analytics cookies help us improve our application by collecting and reporting info on how you use it.',
            analyticsSwitch,
            (value) {
              setState(() {
                analyticsSwitch = value;
              });
            },
          ),
          _buildSwitchTile(
            'Personalization',
            'Personalization cookies collect information about your use of this app in order to display content and experience that are relevant to you.',
            personalizationSwitch,
            (value) {
              setState(() {
                personalizationSwitch = value;
              });
            },
          ),
          _buildSwitchTile(
            'Marketing',
            'Marketing cookies collect information about your use of this and other apps to enable display ads and other marketing that is more relevant to you.',
            marketingSwitch,
            (value) {
              setState(() {
                marketingSwitch = value;
              });
            },
          ),
          _buildSwitchTile(
            'Social media cookies',
            'These cookies are set by a range of social media services that we have added to the site to enable you to share our content with your friends and networks.',
            socialMediaSwitch,
            (value) {
              setState(() {
                socialMediaSwitch = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String description, bool value,
      ValueChanged<bool> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Divider(),
      ],
    );
  }
}

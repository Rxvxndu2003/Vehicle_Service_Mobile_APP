import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_app/controllers/user_controller.dart';
import 'package:vehicle_app/models/profile_details.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  late Future<Profile> futureProfile;
  final UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  Future<Profile> fetchProfile() async {
    final response = await http.get(Uri.parse('https://rxvxndu2003.github.io/privacy/profile.json'));

    if (response.statusCode == 200) {
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Details',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<Profile>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          } else {
            final profile = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('images/person.jpeg'), // Replace with your image asset
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userController.userName.value.isNotEmpty
                        ? userController.userName.value
                        : "Guest Name", // Default name if not logged in
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userController.userEmail.value.isNotEmpty
                        ? userController.userEmail.value
                        : "guest@example.com", // Default email if not logged in
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 255, 196, 0),
                    ),
                    title: Text(
                      profile.customerId,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Color.fromARGB(255, 255, 196, 0),
                    ),
                    title: Text(
                      profile.phoneNumber,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 255, 196, 0),
                    ),
                    title: Text(
                      profile.address,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.car_repair_sharp,
                      color: Color.fromARGB(255, 255, 196, 0),
                    ),
                    title: Text(
                      profile.vehicleId,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      CupertinoIcons.car_fill,
                      color: Color.fromARGB(255, 255, 196, 0),
                    ),
                    title: Text(
                      profile.vehicleModel,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ()),
                      // );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : const Color.fromARGB(255, 124, 123, 123),
                    ),
                    label: Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : const Color.fromARGB(255, 124, 123, 123),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 196, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
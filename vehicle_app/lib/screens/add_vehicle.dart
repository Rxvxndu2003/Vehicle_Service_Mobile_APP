import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vehicle_app/widgets/navbar_roots.dart';
import 'package:intl/intl.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {

  final TextEditingController _dateController = TextEditingController();
  
  // Controllers for text fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController vehicleNameController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();

  // Function to retrieve the auth token from SharedPreferences
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Function to add a vehicle
  Future<void> addVehicle() async {
    final token = await getAuthToken(); // Retrieve the token

    if (token == null) {
      print('Authentication token not found.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication token not found.')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('https://4gbxsolutions.com/api/vehicles'), // Replace with your actual API endpoint
      headers: {
        'Authorization': 'Bearer $token', // Use the retrieved token here
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'full_name': fullNameController.text,
        'vehicle_name': vehicleNameController.text,
        'vehicle_number': vehicleNumberController.text,
        'made': _dateController.text,
      }),
    );

    // Print the response for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response headers: ${response.headers}');

    if (response.statusCode == 302) {
      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Vehicle added successfully!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddVehicle()), // Replace 'YourCurrentPage' with the actual page widget
                  ); // Return to the previous page
                },
              ),
            ],
          );
        },
      );
    } else if (response.statusCode == 302) {
      // Handle redirect manually if needed
      final location = response.headers['location'];
      print('Redirect location: $location');
      // You might need to follow the redirect URL or handle it appropriately
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Redirect detected. Location: $location')),
      );
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bad request. Please check your input.')),
      );
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unauthorized. Please login again.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add vehicle: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            size: 20, // Slightly reduced size for a more modern look
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavbarRoots()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: 28, // Size of the notification icon
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Add Your Vehicle Now!!!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(CupertinoIcons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  controller: vehicleNameController,
                  decoration: InputDecoration(
                    labelText: "Vehicle Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(CupertinoIcons.car_fill),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  controller: vehicleNumberController,
                  decoration: InputDecoration(
                    labelText: "Vehicle Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.car_rental_sharp),
                  ),
                ),
              ),
              Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                        labelText: "Made",
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: const Icon(Icons.calendar_month_sharp),
                    ),
                    readOnly: true, // Makes the TextField read-only
                    onTap: () async {
                           DateTime? pickedDate = await showDatePicker(
                           context: context,
                           initialDate: DateTime.now(),
                           firstDate: DateTime(2000),
                           lastDate: DateTime(2101),
                           );
                        if (pickedDate != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                        _dateController.text = formattedDate; // Sets the value of the TextField
                    });
                    }
                 },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: const Color.fromARGB(255, 255, 196, 0),
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      onTap: addVehicle,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: Text(
                            "Add Now",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
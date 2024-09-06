import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Vehicle {
  final String id;  // Add an ID to identify the vehicle
  final String fullName;
  final String vehicleName;
  final String vehicleNumber;
  final String made;

  Vehicle({
    required this.id,
    required this.fullName,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.made,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'].toString(), // Ensure the ID is a string
      fullName: json['full_name'],
      vehicleName: json['vehicle_name'] ?? 'N/A',  // Handle nullable fields
      vehicleNumber: json['vehicle_number'] ?? 'N/A',
      made: json['made'] ?? 'N/A',
    );
  }
}

class VehiclesWidget extends StatefulWidget {
  const VehiclesWidget({Key? key}) : super(key: key);

  @override
  _VehiclesWidgetState createState() => _VehiclesWidgetState();
}

class _VehiclesWidgetState extends State<VehiclesWidget> {
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    fetchVehicles();  // Fetch vehicles when the widget initializes
  }

  // Function to get the authentication token from SharedPreferences
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Function to fetch vehicles from the API
  Future<void> fetchVehicles() async {
    final token = await getAuthToken(); // Retrieve the token

    if (token == null) {
      print('Authentication token not found.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication token not found.')),
      );
      return;
    }

    print('Auth Token: $token'); // Log the token

    final response = await http.get(
      Uri.parse('https://4gbxsolutions.com/api/vehicles/get'), // Ensure this is the correct API endpoint
      headers: {
        'Authorization': 'Bearer $token', // Use the retrieved token here
        'Content-Type': 'application/json',
      },
    );

    // Print the response for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonData = jsonDecode(response.body);

        // Convert JSON data to a list of Vehicle objects
        List<Vehicle> fetchedVehicles = jsonData.map((json) => Vehicle.fromJson(json)).toList();

        // Update the state with the fetched vehicles
        setState(() {
          vehicles = fetchedVehicles;
        });
        print("Updated _vehicles state: $vehicles");
      } catch (e) {
        print('Error decoding JSON: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to parse data.')),
        );
      }
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unauthorized. Please login again.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load vehicles: ${response.statusCode}')),
      );
    }
  }

  // Function to delete a vehicle
  Future<void> deleteVehicle(String id) async {
    final token = await getAuthToken(); // Retrieve the token

    if (token == null) {
      print('Authentication token not found.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication token not found.')),
      );
      return;
    }

    final response = await http.delete(
      Uri.parse('https://4gbxsolutions.com/api/vehicles/$id'), // Use the DELETE route with vehicle ID
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 302) {
      setState(() {
        vehicles.removeWhere((vehicle) => vehicle.id == id);
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Vehicle deleted successfully!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete vehicle: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
            Text(
            "About Vehicle",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          ...vehicles.map((vehicle) => Column(
            children: [
              buildVehicleCard(vehicle),
              const SizedBox(height: 10), // Add space between cards
            ],
          )).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Function to build a card widget for each vehicle
  Widget buildVehicleCard(Vehicle vehicle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              title: Text(
                vehicle.vehicleName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                vehicle.vehicleNumber,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              trailing: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("images/Aqua.jpeg"), // Update with your asset path
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                height: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      vehicle.made,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_city_sharp,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "Kegalle",  // You can customize this field if needed
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "Registered",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    deleteVehicle(vehicle.id); // Call the delete function with vehicle ID
                  },
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 196, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

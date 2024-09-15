import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_app/screens/book_now.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceCenter {
  final String serviceCenter;
  final String location;

  ServiceCenter({
    required this.serviceCenter,
    required this.location,
  });

  factory ServiceCenter.fromJson(Map<String, dynamic> json) {
    return ServiceCenter(
      serviceCenter: json['service_center'] ?? 'N/A',
      location: json['location'] ?? 'N/A',
    );
  }
}

class Service {
  final String serviceName;
  final String description;
  final String price;

  Service({
    required this.serviceName,
    required this.description,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName: json['service_name'] ?? 'N/A',
      description: json['description'] ?? 'N/A',
      price: json['price'] ?? 'N/A',
    );
  }
}

class Appointment {
  final String id;  // Add an ID to identify the vehicle
  final String fullName;
  final ServiceCenter serviceCenter;
  final Service service;
  final String location;
  final String schedule_date;
  final String schedule_time;
  final bool is_completed;

  Appointment({
    required this.id,
    required this.fullName,
    required this.serviceCenter,
    required this.service,
    required this.location,
    required this.schedule_date,
    required this.schedule_time,
    required this.is_completed,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'].toString(), // Ensure the ID is a string
      fullName: json['full_name'],
      serviceCenter: ServiceCenter.fromJson(json['service_center']),  // Handle nullable fields
      service: Service.fromJson(json['services']),
      location: json['location'] ?? 'N/A',
      schedule_date: json['schedule_date'] ?? 'N/A',
      schedule_time: json['schedule_time'] ?? 'N/A',
      is_completed: json['is_completed'] == 1,
    );
  }
}
class UpcomingSchedule extends StatefulWidget {
  const UpcomingSchedule({super.key});

  @override
  State<UpcomingSchedule> createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();  // Fetch appointments when the widget initializes
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Function to fetch appointments from the API
  Future<void> fetchAppointments() async {
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
      Uri.parse('https://4gbxsolutions.com/api/appointments/get'), // Ensure this is the correct API endpoint
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

        // Convert JSON data to a list of Appointment objects
        List<Appointment> fetchedAppointments = jsonData.map((json) => Appointment.fromJson(json)).toList();

        // Update the state with the fetched appointments
        setState(() {
          appointments = fetchedAppointments;
        });
        print("Updated _appointments state: $appointments");
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
        SnackBar(content: Text('Failed to load appointments: ${response.statusCode}')),
      );
    }
  }

  Future<void> deleteAppointment(String id) async {
    final token = await getAuthToken(); // Retrieve the token

    if (token == null) {
      print('Authentication token not found.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication token not found.')),
      );
      return;
    }

    final response = await http.delete(
      Uri.parse('https://4gbxsolutions.com/api/appointments/$id'), // Use the DELETE route with appointment ID
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 302) {
      setState(() {
        appointments.removeWhere((appointment) => appointment.id == id);
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Appointment deleted successfully!'),
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
        SnackBar(content: Text('Failed to delete appointment: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const Text(
            "Upcoming Schedule",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black
            ),
          ),
          const SizedBox(height: 15),
          // Check if there are no appointments
          if (appointments.isEmpty)
            const Center(
              child: Text(
                "User haven't any Schedule !!!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            )
          else
            ...appointments.map((appointment) => Column(
              children: [
                buildAppointmentCard(appointment),
                const SizedBox(height: 10), // Add space between cards
              ],
            )).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Function to build a card widget for each appointment
  Widget buildAppointmentCard(Appointment appointment) {
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
                appointment.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                appointment.serviceCenter.serviceCenter,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              trailing: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("images/eco.png"), // Update with your asset path
              ),
            ),
            ListTile(
              title: Text(
                appointment.service.serviceName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                appointment.location,
                style: const TextStyle(
                  color: Colors.black,
                ),
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
                      appointment.schedule_date,
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
                    Text(
                      appointment.schedule_time,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: appointment.is_completed ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      appointment.is_completed ? "Done" : "Undone",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
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
                    deleteAppointment(appointment.id);
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

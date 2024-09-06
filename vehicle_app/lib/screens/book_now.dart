import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ServiceCenter {
  final int id;
  final String service_center;
  final String location;

  ServiceCenter({
    required this.id,
    required this.service_center,
    required this.location,
  });

  factory ServiceCenter.fromJson(Map<String, dynamic> json) {
    return ServiceCenter(
      id: json['id'],
      service_center: json['service_center'],
      location: json['location'],
    );
  }
}

class Service {
  final int id;
  final int service_center_id;
  final String service_name;
  final String location;
  final String description;
  final String price;

  Service({
    required this.id,
    required this.service_center_id,
    required this.service_name,
    required this.location,
    required this.description,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      service_center_id: json['service_center_id'],
      service_name: json['service_name'],
      location: json['location'],
      description: json['description'],
      price: json['price'],
    );
  }
}


class BookNow extends StatefulWidget{
  const BookNow({super.key});

  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  
  String? selectedServiceCenter;
  String? selectedService;

  List<ServiceCenter> serviceCenters = [];
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> bookAppointment() async {
  final token = await getAuthToken();
  if (token == null) {
    print('Authentication token not found.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication token not found.')),
      );
      return;
  }

  final response = await http.post(
    Uri.parse('https://4gbxsolutions.com/api/appointments'), // Your API endpoint
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({
      'full_name': fullNameController.text, // Assuming you have a TextEditingController for the full name field
      'service_center_id': selectedServiceCenter,
      'services_id': selectedService,
      'location': locationController.text, // Assuming you have a TextEditingController for the location field
      'schedule_date': _dateController.text, // Ensure this is in 'YYYY-MM-DD' format
      'schedule_time': _timeController.text, // Ensure this is in 'HH:MM:SS' format
    }),
  );
  print('Full Name: ${fullNameController.text}');
  print('Service Center ID: $selectedServiceCenter');
  print('Service ID: $selectedService');
  print('Location: ${locationController.text}');
  print('Date: ${_dateController.text}');
  print('Time: ${_timeController.text}');

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response headers: ${response.headers}');

  if (response.statusCode == 302) {
    // Show success message
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Your appointment has been booked successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BookNow()), // Replace 'YourCurrentPage' with the actual page widget
              );
              },
            ),
          ],
        );
      },
    );
  } else {
    // Show error message
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to book the appointment. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

   Future<void> loadInitialData() async {
    String? token = await getAuthToken();
    if (token != null) {
      List<ServiceCenter> centers = await fetchServiceCenters(token);
      List<Service> serviceList = await fetchServices(token);
      setState(() {
        serviceCenters = centers;
        services = serviceList;
      });
    }
  }

  
  Future<List<ServiceCenter>> fetchServiceCenters(String token) async {
  final response = await http.get(
    Uri.parse('https://4gbxsolutions.com/api/service-centers'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => ServiceCenter.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load service centers');
  }
  }

  Future<List<Service>> fetchServices(String token) async {
    final response = await http.get(
      Uri.parse('https://4gbxsolutions.com/api/services'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Service.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  bool passToggle = true;
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            size: 32, // Slightly reduced size for a more modern look
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
              Icons.notifications,
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
                  "Book Your Date !!!",
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
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                   child: DropdownButtonFormField<String>(
                   decoration: InputDecoration(
                   border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // More rounded corners
                   ),
                   prefixIcon: const Icon(CupertinoIcons.car_fill),// Light grey background
                   ),
                  dropdownColor: Colors.white, // Dropdown background color
                  style: TextStyle(color: Colors.black, fontSize: 16), // Text style inside dropdown
                  items: [
                      DropdownMenuItem(
                         value: "None",
                         child: Text("Service Center", style: TextStyle(color: Colors.grey)),
                      ),
                  ...serviceCenters.map((ServiceCenter center) {
                      return DropdownMenuItem<String>(
                          value: center.id.toString(),
                          child: Text(center.service_center),
                      );
                    }).toList(),
                  ],
                 onChanged: (value) {
                     setState(() {
                    selectedServiceCenter = value;
                   });
                 },
                 value: selectedServiceCenter ?? "None",
                 ),
              ),
              Padding(
                   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                   child: DropdownButtonFormField<String>(
                   decoration: InputDecoration(
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15), // More rounded corners
                   ),
                   prefixIcon: const Icon(Icons.car_repair_sharp),// Light grey background
                   ),
                   dropdownColor: Colors.white, // Dropdown background color
                   style: TextStyle(color: Colors.black, fontSize: 16), // Text style inside dropdown
                   items: [
                   DropdownMenuItem(
                      value: "None",
                      child: Text("Service", style: TextStyle(color: Colors.grey)),
                   ),
                   ...services.map((Service service) {
                   return DropdownMenuItem<String>(
                       value: service.id.toString(),
                       child: Text(service.service_name),
                   );
                   }).toList(),
                   ],
                   onChanged: (value) {
                       setState(() {
                       selectedService = value;
                      });
                   },
                  value: selectedService ?? "None",
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "Location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(CupertinoIcons.location_fill),
                  ),
                ),
              ),
              Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                        labelText: "Date",
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                   controller: _timeController,
                   decoration: InputDecoration(
                      labelText: "Time",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.lock_clock_sharp),
                   ),
                   readOnly: true, // Makes the TextField read-only
                   onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                           context: context,
                           initialTime: TimeOfDay.now(),
                        );
                   if (pickedTime != null) {
                      final now = DateTime.now();
                      final formattedTime = DateFormat('hh:mm:ss').format(
                          DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
                      );
                      setState(() {
                           _timeController.text = formattedTime; // Sets the value of the TextField
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
                        onTap: () {
                         bookAppointment();
                        },
                        child: const Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Center(
                            child: Text(
                              "Book Now",
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
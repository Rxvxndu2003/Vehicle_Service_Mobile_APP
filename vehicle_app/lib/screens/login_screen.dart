import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_app/controllers/user_controller.dart';
import 'package:vehicle_app/screens/home_screen.dart';
import 'package:vehicle_app/screens/signup_screen.dart';
import 'package:vehicle_app/screens/welcome_screen.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController userController = Get.put(UserController());

  bool passToggle = true;
  String? _errorMessage;
  bool _isEmailEmpty = false;
  bool _isPasswordEmpty = false;

  Future<void> _getCsrfToken() async {
    await http.get(Uri.parse('https://4gbxsolutions.com/sanctum/csrf-cookie'));
  }

  Future<void> _login() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  setState(() {
    _isEmailEmpty = email.isEmpty;
    _isPasswordEmpty = password.isEmpty;
  });

  if (_isEmailEmpty || _isPasswordEmpty) {
    return; // Stop if email or password is empty
  }

  try {
    await _getCsrfToken(); // Ensure CSRF token is fetched if required by backend

    final response = await http.post(
      Uri.parse('https://4gbxsolutions.com/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final responseBody = jsonDecode(response.body);
    print('API Response: $responseBody'); // Print the entire response

    if (response.statusCode == 200 && responseBody['status'] == true) {
      final token = responseBody['token'];
      
      // Check if the 'user' field exists and is not null
      final userName = responseBody.containsKey('user') && responseBody['user'] != null 
          ? responseBody['user']['name'] 
          : 'Guest'; // Default to 'Guest' if name is missing

      if (token == null || token.isEmpty) {
        setState(() {
          _errorMessage = 'Failed to retrieve token.';
        });
        return;
      }

      // Save the token and user name
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('user_name', userName); // Save the user's name

      // Update the UserController with the user's email and name
      userController.setUserEmail(email);
      userController.setUserName(userName); // Set the user name in the controller

      // Optional: Log the token and user name to verify
      print('Saved Token: $token');
      print('Saved User Name: $userName');

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavbarRoots()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
    } else {
      setState(() {
        _errorMessage = responseBody['message'] ?? 'Login failed';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!)),
      );
    }
  } catch (e) {
    print('Login Error: $e');
    setState(() {
      _errorMessage = 'An error occurred. Please try again.';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_errorMessage!)),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ));
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Image.asset(
                    "images/M&NLogo.png",
                    height: 150,
                  ),
                ),
                const SizedBox(height: 10),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: const Text("Enter Email"),
                      prefixIcon: const Icon(Icons.person),
                      errorText: _isEmailEmpty ? 'Email is required' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: passToggle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: const Text("Enter Password"),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(
                          passToggle
                              ? CupertinoIcons.eye_slash_fill
                              : CupertinoIcons.eye_fill,
                        ),
                      ),
                      errorText: _isPasswordEmpty ? 'Password is required' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: const Color.fromARGB(255, 255, 196, 0),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: _login,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 18,
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

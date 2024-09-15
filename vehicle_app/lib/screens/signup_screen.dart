import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_app/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passToggle = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  String? _errorMessage;

  bool _isNameEmpty = false;
  bool _isEmailEmpty = false;
  bool _isPhoneEmpty = false;
  bool _isAddressEmpty = false;
  bool _isDobEmpty = false;
  bool _isPasswordEmpty = false;
  bool _isConfirmPasswordEmpty = false;

  Future<void> _getCsrfToken() async {
    await http.get(Uri.parse('https://4gbxsolutions.com/sanctum/csrf-cookie'));
  }

  Future<void> _signUp() async {
  await _getCsrfToken();

  final name = _nameController.text;
  final email = _emailController.text;
  final phone = _phoneController.text;
  final address = _addressController.text;
  final dob = _dobController.text;
  final password = _passwordController.text;
  final confirmPassword = _confirmPasswordController.text;

  setState(() {
    _isNameEmpty = name.isEmpty;
    _isEmailEmpty = email.isEmpty;
    _isPhoneEmpty = phone.isEmpty;
    _isAddressEmpty = address.isEmpty;
    _isDobEmpty = dob.isEmpty;
    _isPasswordEmpty = password.isEmpty;
    _isConfirmPasswordEmpty = confirmPassword.isEmpty;
  });

  if (_isNameEmpty || _isEmailEmpty || _isPhoneEmpty || _isAddressEmpty || _isDobEmpty || _isPasswordEmpty || _isConfirmPasswordEmpty) {
    return;
  }

  if (password != confirmPassword) {
    _showSnackBar('Passwords do not match');
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('https://4gbxsolutions.com/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'dob': dob,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    if (response.headers['content-type']?.contains('application/json') ?? false) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _showSnackBar('User Created Successfully');
        
        // Clear form fields after successful registration
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _addressController.clear();
        _dobController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();

        // Refresh the page by resetting the form (setState)
        setState(() {});

        // Navigate to the login screen after a short delay
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      } else {
        setState(() {
          _errorMessage = responseData['message'] ?? 'Registration failed';
        });
        _showSnackBar(_errorMessage!);
      }
    } else {
      _showSnackBar('Unexpected server response');
    }
  } catch (e) {
    _showSnackBar('An error occurred: $e');
  }
}


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                _buildLogo(),
                _buildFormFields(),
                _buildSignUpButton(),
                _buildLoginPrompt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => const LoginScreen(),
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
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Image.asset("images/M&NLogo.png", height: 150),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          controller: _nameController,
          label: "Full Name",
          prefixIcon: Icons.person,
          isEmpty: _isNameEmpty,
        ),
        _buildTextField(
          controller: _emailController,
          label: "Email Address",
          prefixIcon: Icons.email,
          isEmpty: _isEmailEmpty,
        ),
        _buildTextField(
          controller: _phoneController,
          label: "Phone",
          prefixIcon: Icons.phone,
          isEmpty: _isPhoneEmpty,
        ),
        _buildTextField(
          controller: _addressController,
          label: "Address",
          prefixIcon: Icons.home,
          isEmpty: _isAddressEmpty,
        ),
        _buildTextField(
          controller: _dobController,
          label: "DOB",
          prefixIcon: Icons.calendar_month,
          isEmpty: _isDobEmpty,
        ),
        _buildPasswordField(
          controller: _passwordController,
          label: "Password",
          isEmpty: _isPasswordEmpty,
        ),
        _buildPasswordField(
          controller: _confirmPasswordController,
          label: "Confirm Password",
          isEmpty: _isConfirmPasswordEmpty,
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: const Color.fromARGB(255, 255, 196, 0),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: _signUp,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Center(
                child: Text(
                  "Sign Up",
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
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
          },
          child: Text(
            "Log In",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    double borderRadius = 15.0,
    bool isEmpty = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              prefixIcon: Icon(prefixIcon),
              errorText: isEmpty ? '$label is required' : null,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildPasswordField({
    required TextEditingController controller,
    required String label,
    bool isEmpty = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            obscureText: passToggle,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              prefixIcon: const Icon(Icons.lock),
              errorText: isEmpty ? '$label is required' : null,
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
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:vehicle_app/screens/Onboarding_screen2.dart';
import 'package:vehicle_app/screens/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              'images/service1.png', // Replace with your image path
              height: 300,
            ),
            SizedBox(height: 20),
            Text(
              'Find the service you’ve\nbeen looking for',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Here you’ll see various types of services,\n carefully classified for seamless service experience.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(
                      builder: (context) => OnboardingScreen2(),
                    ));
                  },
                  backgroundColor: Color(0xFFFFD700),
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

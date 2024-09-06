import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vehicle_app/screens/menue_screen.dart';

class ConnectivityStatusScreen extends StatefulWidget {
  const ConnectivityStatusScreen({super.key});

  @override
  _ConnectivityStatusScreenState createState() => _ConnectivityStatusScreenState();
}

class _ConnectivityStatusScreenState extends State<ConnectivityStatusScreen> {
  late Timer _timer;
  String _connectionStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkConnectivity();
    });
  }

  Future<void> _checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (mounted) {
          setState(() {
            _connectionStatus = 'Connected to the Internet';
          });
        }
      }
    } on SocketException catch (_) {
      if (mounted) {
        setState(() {
          _connectionStatus = 'No network connection';
        });
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MenueScreen()),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "Network Connectivity Status",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _connectionStatus == 'No network connection'
                          ? Icons.signal_wifi_off
                          : Icons.signal_wifi_4_bar,
                      size: 100,
                      color: _connectionStatus == 'No network connection'
                          ? Colors.red
                          : Colors.green,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Connection Status:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _connectionStatus,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

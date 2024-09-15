import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart'; // Add this package for a circular battery indicator

class BatteryStatusScreen extends StatefulWidget {
  @override
  _BatteryStatusScreenState createState() => _BatteryStatusScreenState();
}

class _BatteryStatusScreenState extends State<BatteryStatusScreen> {
  final Battery _battery = Battery();
  int _batteryLevel = 0;
  BatteryState? _batteryState;

  @override
  void initState() {
    super.initState();

    // Get the current battery level
    _getBatteryLevel();

    // Listen to the battery state changes (charging, full, or discharging)
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
      });
    });
  }

  // Method to get the battery level
  Future<void> _getBatteryLevel() async {
    final int batteryLevel = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold (
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp,
          size: 28, 
          color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                            ),
          onPressed: () {
           Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavbarRoots(initialIndex: 4,),
              ),
            );
          },
        ),
        title: Text('Battery',
         style: TextStyle(
          fontSize: 24,
          color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
         ),
        ),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular battery level indicator
            CircularPercentIndicator(
              radius: 150.0,
              lineWidth: 15.0,
              percent: _batteryLevel / 100,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.battery_std,
                    size: 50,
                    color: _getBatteryColor(_batteryLevel),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_batteryLevel%',
                    style: TextStyle(
                    fontSize: 40, 
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                    ),
                  ),
                ],
              ),
              progressColor: _getBatteryColor(_batteryLevel),
              backgroundColor: Colors.grey[300]!,
            ),
            const SizedBox(height: 30),
            // Battery state (charging, full, discharging)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _batteryState == BatteryState.charging
                      ? Icons.battery_charging_full
                      : _batteryState == BatteryState.full
                          ? Icons.battery_full
                          : Icons.battery_alert,
                  color: _batteryState == BatteryState.charging ? Colors.green : Colors.red,
                  size: 40,
                ),
                const SizedBox(width: 10),
                Text(
                  _batteryState == BatteryState.charging
                      ? "Charging"
                      : _batteryState == BatteryState.full
                          ? "Full"
                          : "Discharging",
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Refresh button with modern design
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Color.fromARGB(255, 255, 196, 0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Refresh Battery Level',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: _getBatteryLevel,
            ),
          ],
        ),
      ),
    );
  }

  // Function to determine battery color based on the battery level
Color _getBatteryColor(int batteryLevel) {
  if (batteryLevel > 75) {
    return Colors.green;
  } else if (batteryLevel > 30) {
    return Colors.green;
  } else if (batteryLevel <= 20) {
    return Colors.red;
  } else {
    return Colors.green; // Change this to any color you prefer for the 21-29% range
  }
}

}

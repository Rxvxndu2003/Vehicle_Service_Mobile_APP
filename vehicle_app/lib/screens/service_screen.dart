import 'package:flutter/material.dart';
import 'package:vehicle_app/widgets/engine_service.dart';
import 'package:vehicle_app/widgets/tyre_service.dart';
import 'package:vehicle_app/widgets/vehicle_service.dart';


class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  // const ScheduleScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int _buttonIndex = 0;

  final _scheduleWidgets = [
    //Upcoming Widget
    const VehicleService(),

    // Completed Widget
    const EngineService(),

    //Canceled Widget
    const TyreService(),
 
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Services",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,  
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 234, 237),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                       setState(() {
                          _buttonIndex = 0;
                       });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: _buttonIndex == 0 ? const Color.fromARGB(255, 255, 196, 0) : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Vehicle",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _buttonIndex == 0 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                         setState(() {
                          _buttonIndex = 1;
                       });
                     },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: _buttonIndex == 1 ? const Color.fromARGB(255, 255, 196, 0) : Colors.transparent, 
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Engine",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _buttonIndex == 1 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                        setState(() {
                          _buttonIndex = 2;
                       });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: _buttonIndex == 2 ? const Color.fromARGB(255, 255, 196, 0) : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Tyre",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _buttonIndex == 2 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _scheduleWidgets[_buttonIndex],
          ],
        ),
      ),
    );
  }
}



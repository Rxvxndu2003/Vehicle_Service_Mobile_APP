import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_app/screens/add_vehicle.dart';
import 'package:vehicle_app/screens/book_now.dart';
import 'package:vehicle_app/screens/home_screen.dart';
import 'package:vehicle_app/screens/menue_screen.dart';
import 'package:vehicle_app/screens/products_screen.dart';
import 'package:vehicle_app/screens/schedule_screen.dart';
import 'package:vehicle_app/screens/service_screen.dart';
import 'package:vehicle_app/screens/vehicles_screen.dart';


class NavbarRoots extends StatefulWidget{
  @override
  State<NavbarRoots> createState() => _NavbarRootsState();
}

class _NavbarRootsState extends State<NavbarRoots> {

  int _selectedIndex = 0;
  final _screens = [
    //home screen
    HomeScreen(),
    //book now
    ScheduleScreen(),
    //Appointment
    ProductsPage(),
    //Products
    ServiceScreen(),
    //Services
    VehiclesScreen(),
    //Vehicle


    BookNow(),
    AddVehicle(),
    MenueScreen(),



  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          // backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 255, 196, 0),
          unselectedItemColor:Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
          selectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          currentIndex: _selectedIndex,
          onTap:  (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart_fill),
              label: "Products",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.car_repair_sharp),
              label: "Service",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.car_fill),
              label: "Vehicles",
            ),
          ],
        ),
      )
    );
  }
}
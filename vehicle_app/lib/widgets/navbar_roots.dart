
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_app/screens/CartSummary_Screen.dart';
import 'package:vehicle_app/screens/add_vehicle.dart';
import 'package:vehicle_app/screens/book_now.dart';
import 'package:vehicle_app/screens/home_screen.dart';
import 'package:vehicle_app/screens/menue_screen.dart';
import 'package:vehicle_app/screens/products_screen.dart';
import 'package:vehicle_app/screens/schedule_screen.dart';
import 'package:vehicle_app/screens/service_screen.dart';
import 'package:vehicle_app/screens/vehicles_screen.dart';


class NavbarRoots extends StatefulWidget{

  final int initialIndex; // Add this line

  const NavbarRoots({super.key, this.initialIndex = 0});

  @override
  State<NavbarRoots> createState() => _NavbarRootsState();
}

class _NavbarRootsState extends State<NavbarRoots> {
late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Set the initial index from the passed parameter
  }

  final _screens = [
    //home screen
     HomeScreen(),
    //book now
    const ScheduleScreen(),
    //Appointment
    const ProductsPage(),
    //Products
    const  ServicesPage(),
    //Services
    const MenueScreen(),

    const BookNow(),
    const AddVehicle(),



  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          // backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 255, 196, 0),
          unselectedItemColor:Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
          selectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          currentIndex: _selectedIndex,
          onTap:  (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
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
              icon: Icon(CupertinoIcons.bag_fill),
              label: "Services",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: "Profile",
            ),
          ],
        ),
      )
    );
  }
}
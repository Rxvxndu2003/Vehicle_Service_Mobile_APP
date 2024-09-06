import 'package:flutter/material.dart';
import 'package:vehicle_app/screens/add_vehicle.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';
import 'package:vehicle_app/widgets/vehicles_widget.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Modern background color
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp,
          size: 32, 
          color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                            ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const NavbarRoots(),
                    ));
          },
        ),
        title: Text(
          "Vehicles",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // This makes the body scrollable
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: VehiclesWidget(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const AddVehicle(),
                    ));
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vehicle_app/screens/book_now.dart';

class PendingVehicles extends StatelessWidget {
  const PendingVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const Text(
            "About Vehicle",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6FA),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Toyota Axio",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                         color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "CAB-7345",
                      style: TextStyle(
                         color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black,
                      ),
                    ),
                    trailing: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("images/Aqua.jpeg"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      thickness: 1,
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    const Row(
                      children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "06/06/2024",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      ],
                    ),
                     const Row(
                      children: [
                      Icon(
                        Icons.location_city_sharp,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Kegalle",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                       ),
                      ],
                     ),
                     Row(
                      children: [
                        Container(
                           padding: const EdgeInsets.all(5),
                           decoration: const BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                           ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "Pending",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                     ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          
                        },
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 158, 160, 163),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context) => const BookNow()
                          ));
                        },
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 196, 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ), 
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
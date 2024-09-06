import 'package:flutter/material.dart';

class TyreService extends StatelessWidget {
  const TyreService ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const Text(
            "About Service",
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
                      "Tyre Replacement",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                         color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "VS-0004",
                      style: TextStyle(
                         color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black,
                      ),
                    ),
                    trailing: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("images/econoplus.jpg"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      thickness: 1,
                      height: 20,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Row(
                      children: [
                      Icon(
                        Icons.circle_sharp,
                        size: 15,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Safety and Performance",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ],
                    ),
                    ],
                  ),
                  const SizedBox(height: 15),
                   const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Row(
                      children: [
                      Icon(
                        Icons.circle_sharp,
                        size: 15,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Proper Tire Selection and Installation",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ],
                    ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          //  Navigator.push(context, MaterialPageRoute(
                          //      builder: (context) => BookNow()
                          // ));
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
                              "View More",
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
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
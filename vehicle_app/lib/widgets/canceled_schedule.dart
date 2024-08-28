import 'package:flutter/material.dart';
import 'package:vehicle_app/screens/book_now.dart';

class CanceledSchedule extends StatelessWidget {
  const CanceledSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            "About Service",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xFFF4F6FA),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
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
                      "Full Body Wash",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                         color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "VS-0001",
                      style: TextStyle(
                           color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black,
                      ),
                    ),
                    trailing: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("images/econoplus.jpg"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      thickness: 1,
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Row(
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
                     Row(
                      children: [
                      Icon(
                        Icons.access_time_filled,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "10.30 AM",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                       ),
                      ],
                     ),
                     Row(
                      children: [
                        Container(
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                           ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Canceled",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                     ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context) => BookNow()
                          ));
                        },
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 60, 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
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
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ), 
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
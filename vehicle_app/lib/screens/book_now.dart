import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';


class BookNow extends StatefulWidget{
  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  bool passToggle = true;
  @override
        Widget build(BuildContext context) {
    return Material(
      // color: Colors.white,
      child: SingleChildScrollView(
         padding: EdgeInsets.only(top: 20),
        child: SafeArea(
          child: Column(
            children: [
               Padding(
               padding: EdgeInsets.symmetric(horizontal: 15),
               child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(
                               builder: (context) => NavbarRoots()
                          ));
                  },
                 child: Icon(Icons.arrow_back_rounded,
                 size: 40,
                 ),
                ),

               Padding(
                padding: EdgeInsets.only(
                  left:20,
                  ),
                ),
                Spacer(),
                IconButton(
                onPressed: (){},
                icon: Icon(Icons.notification_add_sharp,
                 size: 40,
                 color: Color.fromARGB(255, 255, 196, 0),
                 ),
               ),
              ],
            ),
          ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Book Your Date !!!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Vehicle ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(CupertinoIcons.car_fill),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Service Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.car_repair_sharp),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Date & Time",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.calendar_month_sharp),
                  ),
                ),
              ),
              SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: Color.fromARGB(255, 255, 196, 0),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          //    Navigator.push(context, MaterialPageRoute(
                          //      builder: (context) => LoginScrenn()
                          // ));
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Center(
                            child: Text(
                              "Book Now",
                               style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
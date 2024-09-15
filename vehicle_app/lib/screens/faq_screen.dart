import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vehicle_app/widgets/navbar_roots.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<dynamic> faqData = [];

  // Load the FAQ data from the JSON file
  Future<void> loadFAQData() async {
    final String jsonString = await rootBundle.loadString('assets/data.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      faqData = jsonResponse;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFAQData();
  }

  @override
  Widget build(BuildContext context) {
   final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold( 
      backgroundColor: backgroundColor,// Modern background color
      appBar: AppBar(
        elevation: 0,
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
        title: Text(
          "FAQ",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
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
      body: faqData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: faqData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.all(16.0),
                      title: Text(
                        faqData[index]['question'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            faqData[index]['answer'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

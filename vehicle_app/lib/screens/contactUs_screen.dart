import 'package:flutter/material.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';

class ContactUsScreen extends StatelessWidget {
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
          "Contact Us",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Get in Touch",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color:  Color.fromARGB(255, 255, 196, 0),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We'd love to hear from you! Please fill out the form below to contact us.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 30),

            // Name TextField
            TextField(
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Email TextField
            TextField(
              decoration: InputDecoration(
                labelText: 'Your Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Message TextField
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Your Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Send Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle the form submission logic
                },
                icon: Icon(Icons.send,
                  color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.black,
                ),
                label: Text("Send Message",
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 196, 0),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Contact Information Section
            Center(
              child: Row(
                children: [
                  ContactInfoRow(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'mnservice@gmail.com',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Row(
                children: [
                  ContactInfoRow(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: '+94 (35) 456-7890',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Row(
                children: [
                  ContactInfoRow(
                    icon: Icons.location_on,
                    label: 'Address',
                    value: '123 Main Street, Kegalle, Sri Lanka',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ContactInfoRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color:Color.fromARGB(255, 255, 196, 0)),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                 color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[600]
                            : Colors.black,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(255, 181, 180, 180)
                            : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

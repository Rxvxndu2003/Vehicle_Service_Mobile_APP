import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vehicle_app/screens/add_vehicle.dart';
import 'package:vehicle_app/screens/book_now.dart';
import 'package:vehicle_app/widgets/front_items.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Define state variables for filters
  double _minPrice = 0.0;
  double _maxPrice = 10000.0;
  double _selectedMinPrice = 0.0;
  double _selectedMaxPrice = 10000.0;
  double _selectedRating = 0.0;

  final List<String> carouselImages = [
    'images/aston.jpg',
    'images/benz.jpg',
    'images/bmw.jpg',
  ];
  final List<String> carouselImages2 = [
    'images/mustang.jpg',
    'images/gtr.jpg',
    'images/bugati.jpg',
  ];

  final List<Map<String, String>> products = [
    {"name": "Mountain Warehouse", "price": "\$420", "oldPrice": "\$540", "discount": "20%", "image": "images/about.jpg"},
    {"name": "Mountain Beta Warehouse", "price": "\$800", "oldPrice": "", "discount": "", "image": "images/aston.jpg"},
    {"name": "Nike FS", "price": "\$390.36", "oldPrice": "\$470", "discount": "30%", "image": "images/bmw.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'images/wordlogo.png',
           height: 130,
           fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,
            color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              // Add functionality for the search button here
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined,
            color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              // Add functionality for notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider
           const  SizedBox(height: 20,),
       CarouselSlider(
  options: CarouselOptions(
    height: 180,
    enlargeCenterPage: true,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 3),
    viewportFraction: 1.0, // Ensures the items take up the full width
  ),
  items: carouselImages.map((imagePath) {
    return Builder(
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Full-width image with rounded corners
            Container(
              width: MediaQuery.of(context).size.width, // Full width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient overlay
            Container(
              width: MediaQuery.of(context).size.width, // Full width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
            // Text overlay
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "SPECIAL OFFER",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "SUMMER SALE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "UP TO 80% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Add custom right arrow icon on top
            Positioned(
              right: 20,
              top: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }).toList(),
),

            const SizedBox(height: 20),

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureCard(
                  context,
                  icon: CupertinoIcons.calendar,
                  title: "Book Now",
                  subtitle: "Make an appointment",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const BookNow()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  icon: CupertinoIcons.car_detailed,
                  title: "Manage Vehicle",
                  subtitle: "Add your own Vehicle",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const AddVehicle()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Categories Section
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal, // Enables horizontal scrolling
    child: Row(
      children: [
        FilterButton(text: 'All Categories', isSelected: true),
        const SizedBox(width: 8), // Add spacing between buttons
        FilterButton(text: 'Full Service'),
        const SizedBox(width: 8),
        FilterButton(text: 'Oil'),
        const SizedBox(width: 8),
        FilterButton(text: 'Engine'),
        const SizedBox(width: 8),
        FilterButton(text: 'Tyre'),
        const SizedBox(width: 8),
        FilterButton(text: 'Spare Parts'),
        // Add more buttons if needed
      ],
    ),
  ),
),

            const SizedBox(height: 20),

            CarouselSlider(
  options: CarouselOptions(
    height: 180,
    enlargeCenterPage: true,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 3),
    viewportFraction: 1.0, // Ensures the items take up the full width
  ),
  items: carouselImages2.map((imagePath) {
    return Builder(
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Full-width image with rounded corners
            Container(
              width: MediaQuery.of(context).size.width, // Full width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient overlay
            Container(
              width: MediaQuery.of(context).size.width, // Full width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
            // Text overlay
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "SHOP NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "GRAB YOURS NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "UP TO 80% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Add custom right arrow icon on top
            Positioned(
              right: 20,
              top: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }).toList(),
),
            const SizedBox(height: 20,),
            // Popular Products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FrontItems(searchQuery: _searchQuery, minPrice: _minPrice, maxPrice: _maxPrice, minRating: _selectedRating),
            // Flash Sale Section
            const SizedBox(height: 20),
            Stack(
  children: [
    Container(
      height: 175,
      width: MediaQuery.of(context).size.width, // Full width of the screen
      margin: EdgeInsets.symmetric(horizontal: 0.0), // No horizontal margin for full width
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/about.jpg'), // Your background image
          fit: BoxFit.cover, // Cover the entire container
        ),
      ),
      child: Container(
        // Gradient overlay
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.9),
              Colors.black.withOpacity(0.2),
            ],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Super Flash Sale 50% Off',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CountdownTimer(time: '07', label: 'Hours'),
                CountdownTimer(time: '58', label: 'Minutes'),
                CountdownTimer(time: '23', label: 'Seconds'),
              ],
            ),
          ],
        ),
      ),
    ),
  ],
),
const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}

// Filter button widget
class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  FilterButton({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Color.fromARGB(255, 255, 196, 0) : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// Countdown timer widget
class CountdownTimer extends StatelessWidget {
  final String time;
  final String label;

  CountdownTimer({required this.time, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          time,
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

Widget _buildFeatureCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 196, 0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }


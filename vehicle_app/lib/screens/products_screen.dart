import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_app/screens/CartSummary_Screen.dart';
import 'package:vehicle_app/screens/home_screen.dart';
import 'package:vehicle_app/widgets/items_widget.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';
import 'package:vehicle_app/widgets/product_items.dart';
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}
class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Define state variables for filters
  double _minPrice = 0.0;
  double _maxPrice = 10000.0;
  double _selectedMinPrice = 0.0;
  double _selectedMaxPrice = 10000.0;
  double _selectedRating = 0.0;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Image.asset(
          'images/wordlogo.png',
           height: 130,
           fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.bag_fill,
            color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartSummaryPage(),
                        ),
                      );
            },
          ),
          IconButton(
            onPressed: () {
              _showFilterDialog();
            },
            icon: Icon(
              Icons.filter_list,
              size: 32,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 20),
            _buildPromotionBanner(), // Add this promotional banner here
            const SizedBox(height: 20),
            ItemsWidget(
              searchQuery: _searchQuery,
              minPrice: _selectedMinPrice,
              maxPrice: _selectedMaxPrice,
              minRating: _selectedRating,
            ), // Pass filters to ProductItems
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new product functionality
        },
        backgroundColor: const Color.fromARGB(255, 255, 196, 0),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildPromotionBanner() {
    return Stack(
      children: [
        Container(
          height: 250, // Adjust height as per your need
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('images/gtr.jpg'), // Your background image
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '50% Special Offer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Summer Sale',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Shop Now >',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  // Method to build a modern search bar
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 234, 237),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search here...",
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.black,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Filter Products'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Price Range'),
                  RangeSlider(
                    values: RangeValues(_selectedMinPrice, _selectedMaxPrice),
                    min: _minPrice,
                    max: _maxPrice,
                    divisions: 20,
                    labels: RangeLabels(
                      _selectedMinPrice.toStringAsFixed(0),
                      _selectedMaxPrice.toStringAsFixed(0),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _selectedMinPrice = values.start;
                        _selectedMaxPrice = values.end;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Minimum Rating'),
                  Slider(
                    value: _selectedRating,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: _selectedRating.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _selectedRating = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      // Apply filters
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

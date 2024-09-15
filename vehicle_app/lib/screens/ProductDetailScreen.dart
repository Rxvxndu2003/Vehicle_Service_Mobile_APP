import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_app/screens/CartSummary_Screen.dart';
import 'dart:convert';
import 'package:vehicle_app/screens/products_screen.dart';
import 'package:vehicle_app/widgets/items_widget.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';
import 'package:vehicle_app/widgets/product_items.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> addToCart(int productId) async {
    final token = await getAuthToken(); 
    final url = Uri.parse('https://4gbxsolutions.com/api/cart/add'); // Replace with your backend URL

    // Make the POST request
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Add token in headers for authentication
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': productId, // Pass the product ID to the request
      }),
    );

    if (response.statusCode == 200) {
      // Handle success response
      final jsonResponse = jsonDecode(response.body);
      print('Success: ${jsonResponse['message']}');
    } else {
      // Handle error response
      print('Failed to add to cart');
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
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
        ],
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
               child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Set the desired border radius
                  child: widget.product.image != null
                        ? Image.network(
                          widget.product.image!,
                          height: 250,
                          width: double.infinity, // Ensure it takes full width
                          fit: BoxFit.cover,
                        )
                        : Container(
                          height: 250,
                          width: double.infinity, // Ensure it takes full width
                          color: Colors.grey[300],
                          child: const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.grey,
                          ),
                        ),
                 ),
              ),
            const SizedBox(height: 20),
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Rs.${widget.product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < widget.product.rating.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 24,
                );
              }),
            ),
            const SizedBox(height: 20),
            // Default Product Description
            Text(
              'Imagine a vehicle that seamlessly blends the comfort of a luxury sedan with the rugged capabilities of an SUV.** This versatile machine boasts a sleek, aerodynamic design, paired with a spacious interior featuring premium materials and cutting-edge technology. Equipped with a powerful, fuel-efficient engine, it delivers a smooth and exhilarating driving experience. Whether you are commuting to work, embarking on a weekend getaway, or tackling off-road adventures, this vehicle is designed to exceed your expectations.',
              style: TextStyle(fontSize: 16, 
              color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove_circle_outline),
                      color: Colors.blueAccent,
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add_circle_outline),
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    addToCart(widget.product.id);// Handle add to cart functionality
                  },
                  child: Text('Add to Cart',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Added spacing to separate the buttons
            ElevatedButton(
              onPressed: () {
                // Handle buy now functionality
              },
              child: Text('Buy Now',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
              ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

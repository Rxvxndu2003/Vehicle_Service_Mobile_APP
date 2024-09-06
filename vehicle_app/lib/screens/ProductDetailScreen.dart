import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          widget.product.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: widget.product.image != null
                  ? Image.network(
                      widget.product.image!,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
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
                    // Handle add to cart functionality
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vehicle_app/screens/ProductDetailScreen.dart';
import 'package:vehicle_app/screens/products_screen.dart';
import 'package:vehicle_app/widgets/items_widget.dart';



class FrontItems extends StatelessWidget {
  const FrontItems({super.key, required String searchQuery, required double minPrice, required double maxPrice, required double minRating});

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://4gbxsolutions.com/fetch-products'));

    if (response.statusCode == 200) {
  List jsonResponse = json.decode(response.body);
  
  // Limit the response to only the first 5 products
  List limitedProducts = jsonResponse.take(5).toList();
  
  return limitedProducts.map((product) => Product.fromJson(product)).toList();
} else {
  throw Exception('Failed to load products');
}

  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    int crossAxisCount;
    double childAspectRatio;

    if (isLandscape) {
      crossAxisCount = (screenWidth / 250).round();
      childAspectRatio = (screenHeight / screenWidth) * 1.3;
    } else {
      crossAxisCount = (screenWidth / 180).round();
      childAspectRatio = (screenWidth / screenHeight) * 1.2;
    }

    return FutureBuilder<List<Product>>(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found'));
        } else {
          final products = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            itemBuilder: (context, index) {
              return ProductItem(product: products[index]);
            },
          );
        }
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>  ProductDetailScreen(product: product),
                    ));
              },
              child: product.image != null
                  ? Image.network(
                      product.image!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                product.name,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < product.rating.round() ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs.${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // "Buy Now" button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsPage(),
                        ),
                      );
                    },
                    icon: const Icon(CupertinoIcons.bag_fill, color: Colors.black),
                    label: const Text('Buy Now'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Color.fromARGB(255, 255, 196, 0), // Text and icon color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

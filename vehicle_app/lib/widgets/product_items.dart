import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? image; // Made image nullable

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.image, // Image can now be null
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? 'No Name', // Provide default value if null
      description: json['description'] ?? 'No Description', // Provide default value if null
      price: double.tryParse(json['price'].toString()) ?? 0.0, // Provide default value if null
      // image: json['image'].startsWith('http')
      //     ? json['image']
      //     : 'https://4gbxsolutions.com/storage/${json['image']}',
    );
  }
}


class ItemsWidget extends StatelessWidget {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://4gbxsolutions.com/fetch-products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
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
      crossAxisCount = (screenWidth / 200).round();
      childAspectRatio = (screenHeight / screenWidth) * 1.3;
    } else {
      crossAxisCount = (screenWidth / 180).round();
      childAspectRatio = (screenWidth / screenHeight) * 1.2;
    }

    return FutureBuilder<List<Product>>(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products found'));
        } else {
          final products = snapshot.data!;
          return GridView.count(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            children: products.map((product) {
              return ProductItem(product: product);
            }).toList(),
          );
        }
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 234, 237),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "-50%",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(10),
              child: product.image != null
                  ? Image.network(
                      product.image!,
                      width: 100,
                      height: 100,
                    )
                  : Icon(Icons.broken_image, size: 100), // Placeholder if image is null
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              product.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              product.description,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

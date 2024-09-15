import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';

class CartSummaryPage extends StatefulWidget {
  const CartSummaryPage({super.key});

  @override
  State<CartSummaryPage> createState() => _CartSummaryPageState();
}

class _CartSummaryPageState extends State<CartSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
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
                builder: (context) => const NavbarRoots(initialIndex: 2,),
              ),
            );
          },
        ),
        title: Text(
          "Cart",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product List
            buildProductItem(
              imageUrl: 'images/4.png',
              name: "Radient Oil",
              price: "\$800",
            ),
            const SizedBox(height: 10),
            buildProductItem(
              imageUrl: 'images/3.png',
              name: "Power Steering Oil",
              price: "\$390.36",
              oldPrice: "\$650.62",
            ),
            const SizedBox(height: 20),

            // Coupon Code Section
            Text(
              "Your Coupon code",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Type coupon code",
                prefixIcon: const Icon(Icons.local_offer_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 20),

            // Order Summary Section
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  OrderSummaryRow(label: "Subtotal", value: "\$169"),
                  OrderSummaryRow(label: "Shipping Fee", value: "Free", isFree: true),
                  OrderSummaryRow(label: "Discount", value: "\$10"),
                  Divider(),
                  OrderSummaryRow(label: "Total (Include of VAT)", value: "\$185"),
                  OrderSummaryRow(label: "Estimated VAT", value: "\$5"),
                ],
              ),
            ),
            const Spacer(),

            // Continue Button
            ElevatedButton(
              onPressed: () {
                // Handle continue action
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color.fromARGB(255, 255, 196, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:Text(
                "Continue",
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductItem({
    required String imageUrl,
    required String name,
    required String price,
    String? oldPrice,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        // Product Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  if (oldPrice != null) ...[
                    const SizedBox(width: 10),
                    Text(
                      oldPrice,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isFree;

  const OrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isFree = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

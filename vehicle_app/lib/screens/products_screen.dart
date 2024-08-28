import 'package:flutter/material.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';
import 'package:vehicle_app/widgets/product_items.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
 @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Padding(
                padding: EdgeInsets.only(
                  left:20,
                  ),
                  child: Text(
                    "Products",
                      style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                       color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                onPressed: (){
                },
                icon: Icon(Icons.filter_list,
                 size: 32,
                 color: Color.fromARGB(255, 255, 196, 0),
                 ),
               ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 233, 234, 237),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search here...",
                          hintStyle: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black,
                          ),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.search_sharp,
                      color:Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.black,
                    ),
                  ],
                ),
              )
            ],
          ),
          ItemsWidget(),
        ],
      ),
    );
  }
}
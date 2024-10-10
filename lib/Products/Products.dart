import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Cart/CartProvider.dart';
 // Import CartProvider

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Product 1'),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addItem('Product 1');
            },
          ),
        ),
        ListTile(
          title: Text('Product 2'),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addItem('Product 2');
            },
          ),
        ),
        ListTile(
          title: Text('Product 3'),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addItem('Product 3');
            },
          ),
        ),
      ],
    );
  }
}

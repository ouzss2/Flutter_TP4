import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cart/CartProvider.dart';
import 'Cart/CartScreen.dart';
import 'Products/Products.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<Home> {
  int _selectedIndex = 0;


  static List<Widget> _widgetOptions = <Widget>[
    HomeP(),        // For the Home tab
    Products(),     // For the Products tab
    About(),        // For the About tab
    Profile(),      // For the Profile tab
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        backgroundColor: Colors.teal,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
              ),
             
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return cart.cartItems.length > 0
                        ? Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cart.cartItems.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container();  // Empty container if no items in cart
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],  // Body changes based on selected tab
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Home page!'),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Profile page!'),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the About page!'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppBar/GlobalAppBar.dart';
import 'Cart/CartProvider.dart';
import 'Cart/CartScreen.dart';
import 'Products/Products.dart';
import 'Screens/About.dart';
import 'Screens/Profile.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<Home> {
  int _selectedIndex = 0;


  static List<Widget> _widgetOptions = <Widget>[
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
      appBar: GlobalAppBar(),
      body: _widgetOptions[_selectedIndex],  // Body changes based on selected tab
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
        
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




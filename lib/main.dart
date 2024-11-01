import 'package:e_commerce/Cart/CartProvider.dart';
import 'package:e_commerce/Home.dart';
import 'package:e_commerce/Products/Products.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Products/CarProvider.dart';
import 'SplashScreen.dart';


void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Shop',
      home: Home()
    );
  }
}



import 'package:e_commerce/Cart/CartProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SplashScreen.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
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
      home: SplashScreen(),
    );
  }
}



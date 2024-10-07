
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'SignInScreen.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: Center(
        child: Lottie.asset(
          'assets/animations/login_animation.json',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

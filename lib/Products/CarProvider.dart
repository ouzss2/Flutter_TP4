import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Classes/Car.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];
  bool _isLoading = false;

  List<Car> get cars => _cars;
  bool get isLoading => _isLoading;

 
  Future<void> fetchCars() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('https://auto.dev/api/listings?apikey=YOUR_API_KEY'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cars = (data['records'] as List).map((car) => Car.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load cars');
    }

    _isLoading = false;
    notifyListeners();
  }






  Future<String> createPayPalPayment(double totalPrice) async {
  /*print("createPayPalPayment called"); 

  final String clientId = 'AaHX4dw5LUfbG90Y8P3Y2H6D49mae2zoeQ-rXdWbnoG_Ka-GChe_AXSj9KkTn3IXECAACw5ctvKGoP8k';
  final String secret = 'ECbjmoOR9vKExC8m7BncwJSDEbgKSlQ1Mqqd3DHPQ-e79G3EHWQJkMnkoq1t78Cpi8sC1AA1Es6o_zIw';

  final String credentials = base64Encode(utf8.encode('$clientId:$secret'));
  print("Encoded credentials: $credentials");

  final response = await http.post(
    Uri.parse('https://api-m.sandbox.paypal.com/v1/oauth2/token'),
    headers: {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {'grant_type': 'client_credentials'},
  );

  print("Access token response status: ${response.statusCode}");
  if (response.statusCode == 200) {
    final accessToken = jsonDecode(response.body)['access_token'];
    print("Access token: $accessToken");*/

final paymentResponse = await http.post(
  Uri.parse('https://api-m.sandbox.paypal.com/v1/payments/payment'),
  headers: {
    'Authorization': 'Bearer A21AALyXRb5gIkWe9ZR6OspYkN3SEOm5v8s2KzJ48ULsNJmLcJjOM_9268p3LT7GhMCuZjO7PMxSN2BwkfatHjSRMlnHUbe7Q',  
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    "intent": "sale",
    "redirect_urls": {
      "return_url": "https://your-return-url.com",
      "cancel_url": "https://your-cancel-url.com"
    },
    "payer": {"payment_method": "paypal"},
    "transactions": [
      {
        "amount": {"total": totalPrice.toString(), "currency": "USD"},
        "description": "Car Purchase"
      }
    ]
  }),
);

if (paymentResponse.statusCode == 201) {
  final paymentData = jsonDecode(paymentResponse.body);
  final approvalUrl = paymentData['links']
      .firstWhere((link) => link['rel'] == 'approval_url')['href'];
  print("Approval URL: $approvalUrl");
} else {
  print("Error creating payment: ${paymentResponse.body}");
}


    print("$totalPrice  response status: ${paymentResponse.statusCode}");
    if (paymentResponse.statusCode == 201) {
      final paymentData = jsonDecode(paymentResponse.body);
      final approvalUrl = paymentData['links']
          .firstWhere((link) => link['rel'] == 'approval_url')['href'];
      print("Approval URL: $approvalUrl");

      return approvalUrl;
    } else {
      print("Failed to create PayPal payment: ${paymentResponse.body}");
      throw Exception('Failed to create PayPal payment');
    }}

}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Classes/Car.dart';
import 'CarProvider.dart';

class ProductDetails extends StatelessWidget {
  final Car car;

  ProductDetails({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${car.year} ${car.make} ${car.model}'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: car.photoUrls.isNotEmpty
                          ? NetworkImage(car.photoUrls[0])
                          : AssetImage('assets/placeholder.png') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${car.price}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '${car.year} ${car.make} ${car.model}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Additional Images:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: car.photoUrls.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: car.photoUrls.isNotEmpty
                          ? Image.network(
                              car.photoUrls[index],
                              width: 300,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 250,
                              height: 100,
                              color: Colors.grey,
                            ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                ),
                onPressed: () async {
                                print("Button pressed"); // Add this line
                                final carProvider = Provider.of<CarProvider>(context, listen: false);
                                try {
                                  double prix = double.parse(
                                    car.price.replaceAll('\$', '').replaceAll(',', '').trim()
                                  );
                                  String approvalUrl = await carProvider.createPayPalPayment(prix);
                                  
                                  if (await canLaunch(approvalUrl)) {
                                    await launch(approvalUrl);
                                  }
                                } catch (e) {
                                  print("Payment failed: $e");
                                }
                              },
                child: Text('Buy Car', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppBar/GlobalAppBar.dart';
import '../Cart/CartProvider.dart';
import 'CarProvider.dart';
import 'ProductDetails.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CarProvider>(context, listen: false).fetchCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CarProvider, CartProvider>(
      builder: (context, carProvider, cartProvider, child) {
        if (carProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        final filteredCars = carProvider.cars.where((car) {
          return car.make.toLowerCase().contains(searchQuery.toLowerCase()) ||
              car.model.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

        return Scaffold(
          body: Column(
            children: [
              SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: 250.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: filteredCars.map((car) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: car.photoUrls.isNotEmpty
                              ? Image.network(
                                  car.photoUrls[0],
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey,
                                ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: filteredCars.length,
                  itemBuilder: (context, index) {
                    final car = filteredCars[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(car: car),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 8,
                        shadowColor: Colors.black.withOpacity(0.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                              child: car.photoUrls.isNotEmpty
                                  ? Image.network(
                                      car.photoUrls[0],
                                      width: double.infinity,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 130,
                                      color: Colors.grey,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${car.year} ${car.make}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.85),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    car.model,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${car.price}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Implement buy car functionality here
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Buying ${car.model}'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.monetization_on), // You can change the icon if needed
                                    label: Text("Buy Car"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

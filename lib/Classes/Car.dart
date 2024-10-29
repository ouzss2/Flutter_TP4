class Car {
  final int id;
  final String vin;
  final int year;
  final String make;
  final String model;
  final String price;
  final String mileage;
  final String city;
  final List<String> photoUrls; 

  Car({
    required this.id,
    required this.vin,
    required this.year,
    required this.make,
    required this.model,
    required this.price,
    required this.mileage,
    required this.city,
    required this.photoUrls, 
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      vin: json['vin'],
      year: json['year'],
      make: json['make'],
      model: json['model'],
      price: json['price'],
      mileage: json['mileage'],
      city: json['city'],
      photoUrls: List<String>.from(json['photoUrls']), 
    );
  }
}

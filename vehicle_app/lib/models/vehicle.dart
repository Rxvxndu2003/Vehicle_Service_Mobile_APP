class Vehicle {
  final int id;
  final String name;
  final String type;
  final String number;
  final String image;

  Vehicle({required this.id, required this.name, required this.type, required this.number, required this.image});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      number: json['number'],
      image: json['image'],
    );
  }
}
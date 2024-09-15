class Product {
  final int id;
  final String name;
  final double rating;
  final double price;
  final String? image;

  Product({
    required this.id,
    required this.name,
    required this.rating,
    required this.price,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? 'No Name',
      rating: json['rating'] is double
          ? json['rating']
          : double.tryParse(json['rating'].toString()) ?? 0.0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'] != null && json['image'].startsWith('http')
          ? json['image']
          : 'https://4gbxsolutions.com/storage/${json['image']}',
    );
  }
}
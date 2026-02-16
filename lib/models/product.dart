class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String brand;
  final double discountPercentage;
  final double price;
  final double rating;
  final String thumbnail; 
  final List<String> images;
  

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.brand,
    required this.discountPercentage,
    required this.price,
    required this.rating,
    required this.thumbnail,  
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      category: json['category'] ?? "",
      brand: json['brand'] ?? "",
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'] ?? "",
      images: List<String>.from(json['images'] ?? []),
    );
  }
}

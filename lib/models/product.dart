class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  /// Chuyển JSON từ Firebase thành object Product
  factory Product.fromJson(Map<String, dynamic> json, String docId) {
    return Product(
      id: docId,
      name: json['name'] ?? 'No name',
      description: json['description'] ?? 'No description',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  /// Chuyển object Product thành JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}

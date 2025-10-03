import 'dart:typed_data';

class Coffee {
  final int id;
  final String name;
  final String description;
  final String category;
  final double price;
  final Uint8List? image; // ✅ make nullable

  Coffee({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    this.image, // ✅ optional
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
  return Coffee(
    id: json['id'] != null ? json['id'] as int : 0,
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    category: json['category'] ?? '',
    price: json['price'] ?? '0',
    image: json['image'] != null
        ? Uint8List.fromList(List<int>.from(json['image']))
        : Uint8List(0),
  );
}


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "category": category,
      "price": price,
      "image": image,
    };
  }
}

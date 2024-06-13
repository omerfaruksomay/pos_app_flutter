class Menu {
  int id;
  String name;
  String price;
  String image;
  int category_id;
  DateTime createdAt;
  DateTime updatedAt;


  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category_id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      category_id: json['category_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }



}
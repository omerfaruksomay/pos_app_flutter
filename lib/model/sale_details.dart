class SaleDetails {
  int sale_id;
  String menu_name;
  int menu_price;
  DateTime createdAt;
  DateTime updatedAt;

  SaleDetails({
    required this.sale_id,
    required this.menu_name,
    required this.menu_price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SaleDetails.fromJson(Map<String, dynamic> json) {
    return SaleDetails(
      sale_id: json['sale_id'],
      menu_name: json['menu_name'],
      menu_price: json['menu_price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sale_id': sale_id,
      'menu_name': menu_name,
      'menu_price': menu_price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
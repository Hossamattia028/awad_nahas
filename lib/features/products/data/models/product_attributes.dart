import 'dart:convert';

class ProductAttributes {
  final double height;
  final double width;
  final double length;
  final double weight;
  final String color;

  ProductAttributes({required this.height,required this.width,required this.length,required this.weight,required this.color});

  static List<ProductAttributes> listModelFromJson(String str) =>
      List<ProductAttributes>.from(
          json.decode(str).map((x) => ProductAttributes.fromJson(x)));


  static ProductAttributes fromJson(Map<String, dynamic> jsonObject) {
    return ProductAttributes(
      height: double.parse(jsonObject['height'] ?? "0"),
      width: double.parse(jsonObject['width'] ?? "0"),
      length: double.parse(jsonObject['length'] ?? "0"),
      weight: double.parse(jsonObject['weight'] ?? "0"),
      color: jsonObject['color'] ?? "",
    );
  }

}
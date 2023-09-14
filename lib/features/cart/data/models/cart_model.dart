import 'dart:convert';
import 'package:awad_nahas/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.id,
    required super.sessionID,
    required super.sessionValue,
    required super.total,
    super.cartSerialize,
      });

  static CartModel fromJson(Map<String, dynamic> jsonObject) {
    List<dynamic> list = [];
    if(jsonObject['cart']!=null&&jsonObject['cart'].toString()!="[]"){
      list = jsonObject['cart'].entries.map((entry) {
        return CartModelProducts(
            productID: entry.value['product_id'],
            quantity: int.parse((entry.value['quantity']??1).toString()),
            price: double.parse(entry.value['line_total'].toString()),
            discount: double.parse(entry.value['discount'].toString()),
            title: entry.value['title'] ?? "",
            imgPath: entry.value['imgPath'] ?? "",
            sku: entry.value['sku'] ?? "",
        );
      }).toList();
    }
    return CartModel(
      id: int.parse(jsonObject['session_id']??"0"),
      sessionID: int.parse(jsonObject['session_id']??"0"),
      sessionValue: list.cast<CartModelProducts>(),
      total: double.parse(jsonObject['cart_totals']==null?"0.0":jsonObject['cart_totals']['total'].toString()),
      // cartSerialize: CartSerialize.fromJson(jsonObject)
    );
  }

}


class CartModelProducts {
  final int productID;
  final int quantity;
  final double price;
  final double discount;
  final String title;
  final String imgPath;
  final String sku;
  const CartModelProducts({
    required this.quantity,required this.productID,
    required this.price,required this.discount,
    required this.imgPath,required this.title,required this.sku});

  static List<CartModelProducts> cartListFromJson(String str) =>
      List<CartModelProducts>.from(
          json.decode(str).map((x) => CartModelProducts.fromJson(x)));

  static CartModelProducts fromJson(Map<String, dynamic> jsonObject) {
    return CartModelProducts(
      productID: jsonObject['product_id'],
      quantity: int.parse((jsonObject['quantity']??1).toString()),
      price: double.parse(jsonObject['line_total'].toString()),
      discount: double.parse(jsonObject['discount'].toString()),
      imgPath: jsonObject['imgPath'] ?? "",
      title: jsonObject['title'] ?? "",
      sku: jsonObject['sku'] ?? "",
    );
  }
}
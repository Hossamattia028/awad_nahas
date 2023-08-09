import 'dart:convert';
import 'package:awad_nahas/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel(
      {required super.id,
      required super.sessionID,
      required super.sessionValue,
      required super.total,
      });

  static CartModel fromJson(Map<String, dynamic> jsonObject) {
    List<dynamic> list =
    jsonObject['products'].entries.map((entry) {
      return CartModelProducts(productID: entry.value['product_id'],quantity: entry.value['quantity']);
    }).toList();
    return CartModel(
      id: int.parse(jsonObject['session_id']??"0"),
      sessionID: int.parse(jsonObject['session_id']??"0"),
      sessionValue: list.cast<CartModelProducts>(),
      total: double.parse(jsonObject['cart_totals']['total'].toString()),
    );
  }

}


class CartModelProducts {
  final int productID;
  final int quantity;
  const CartModelProducts({required this.quantity,required this.productID});

  static List<CartModelProducts> cartListFromJson(String str) =>
      List<CartModelProducts>.from(
          json.decode(str).map((x) => CartModelProducts.fromJson(x)));

  static CartModelProducts fromJson(Map<String, dynamic> jsonObject) {
    return CartModelProducts(
      productID: jsonObject['product_id'],
      quantity: int.parse((jsonObject['quantity']??1).toString()),
    );
  }
}
import 'dart:convert';
import 'package:awad_nahas/features/cart/data/models/cart_serilize_data.dart';
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
        return CartModelProducts(productID: entry.value['product_id'],quantity: int.parse((entry.value['quantity']??1).toString()),price: double.parse(entry.value['line_total'].toString()));
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
  const CartModelProducts({required this.quantity,required this.productID,required this.price});

  static List<CartModelProducts> cartListFromJson(String str) =>
      List<CartModelProducts>.from(
          json.decode(str).map((x) => CartModelProducts.fromJson(x)));

  static CartModelProducts fromJson(Map<String, dynamic> jsonObject) {
    return CartModelProducts(
      productID: jsonObject['product_id'],
      quantity: int.parse((jsonObject['quantity']??1).toString()),
      price: double.parse(jsonObject['line_total'].toString()),
    );
  }
}
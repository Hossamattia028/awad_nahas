import 'dart:convert';
import 'package:awad_nahas/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel(
      {required super.id,
      required super.sessionID,
      required super.sessionKey,
      required super.sessionValue,
      required super.total,
      });


  // static List<CartModel> cartListFromJson(String str) =>
  //     List<CartModel>.from(
  //         json.decode(str).map((x) => CartModel.fromJson(x)));

  static CartModel fromJson(Map<String, dynamic> jsonObject) {
    return CartModel(
      id: jsonObject['session_id'],
      sessionID: jsonObject['session_id'],
      sessionKey: jsonObject['session_key'] ,
      sessionValue: CartModelProducts.cartListFromJson(jsonEncode(jsonObject['session_value']['cart'])) ,
      total: jsonObject['session_value']['cart_totals'].toString()!="[]"?double.parse(jsonObject['session_value']['cart_totals']['total'].toString()):0.0,
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
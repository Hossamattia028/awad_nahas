// ignore_for_file: camel_case_types, constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Orders extends Equatable {
  final int? orderId;
  final int? code;
  final String? userId;
  final String? userName;
  final String? userPhone;
  final String? userEmail;
  final String? userCountry;
  final String? userCity;
  final String? userState;
  final int? addressId;
  final int? managerId;
  final int? driverID;
  final String? driverName;
  final String? area;
  final String? city;
  final String? shippingAddress;
  final String? desc;
  final String? type;
  final double? price;
  final double? discount;
  final String? couponDiscount;
  final double? deliveryPrice;
  final double? packagesPrice;
  final double? totalPrice;
  final double? deposit;
  final bool? isDeposit;
  final String? deliveryMethod;
  final String? paymentMethod;
  final double? lat;
  final double? lng;
  final String? status;
  final String? statusView;
  final String? date;

  final List<OrderItem>? items;

  final String? file;

  // final String rejectedReason;

  const Orders({
    this.items,
    this.orderId,
    this.code,
    this.userId,
    this.userName,
    this.userPhone,
    this.userEmail,
    this.userCountry,
    this.userCity,
    this.userState,
    this.managerId,
    this.driverID,
    this.driverName,
    this.addressId,
    this.desc,
    this.area,
    this.city,
    this.shippingAddress,
    this.status,
    this.statusView,
    this.type,
    this.price,
    this.discount,
    this.couponDiscount,
    this.deliveryPrice,
    this.packagesPrice,
    this.totalPrice,
    this.deposit,
    this.isDeposit,
    this.deliveryMethod,
    this.paymentMethod,
    this.lat,
    this.lng,
    this.date ,
    this.file ,
  });

  @override
  List<Object?> get props => [
        userId,
        managerId,
        addressId,
        status,
        type,
        price,
        totalPrice,
        discount,
        deliveryPrice,
        totalPrice,
        deposit,
        isDeposit,
        deliveryMethod,
        paymentMethod,
        lat,
        lng,
        // rejectedReason
      ];
}


class OrderItem {
  final int id;
  final String title;
  final double price;
  final String qty;
  OrderItem({required this.id,required this.title,required this.price,required this.qty});

  static List<OrderItem> listFromJson(String str) =>
      List<OrderItem>.from(
          json.decode(str).map((x) => OrderItem.fromJson(x)));

  static OrderItem fromJson(Map<String, dynamic> jsonObject) {
    return OrderItem(
      id: int.parse((jsonObject['product_id']??"0").toString()),
      title: jsonObject['order_item_name']??"",
      price: double.parse((jsonObject['price']??0).toString()),
      qty: jsonObject['qty']??"0",
    );
  }
}


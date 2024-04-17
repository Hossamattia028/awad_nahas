

import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class OrderEvent{
  const OrderEvent();
}

class FetchAllOrderEvent extends OrderEvent{
  const FetchAllOrderEvent();
}

class AddOrderEvent extends OrderEvent{
  final List<ProductsEntity> list;
  final double totalPrice;
  final BuildContext context;
  final PaymentOption payment;
  final Map<String,dynamic>? apsData;
  final String? amWalTransactionId;
  final CouponModel? couponModel;
  final double couponVal;
  final double? taxTotal;
  final String orderStatus;
  const AddOrderEvent({required this.list,required this.totalPrice,required this.context,
    required this.payment,this.apsData,this.amWalTransactionId,this.couponModel,
    this.couponVal = 0,this.taxTotal,
    required this.orderStatus
  });
}

class PaymentOption{
  final PaymentEnum paymentEnum;
  final bool? isApplePay;
  const PaymentOption({required this.paymentEnum,this.isApplePay});
}

class CancelOrderEvent extends OrderEvent{
  final int id;
  const CancelOrderEvent({required this.id});
}


class ChangeCurrentOrdersEvent extends OrderEvent{
  final ORDER_STATUS type ;
  final int index;
  final bool updateState;
  const ChangeCurrentOrdersEvent({required this.type,required this.index,this.updateState=false});
}

class UpdateOrderEvent extends OrderEvent{
  final Map<String,dynamic> data;
  const UpdateOrderEvent({required this.data,});
}





class AmwalCheckOpening extends OrderEvent {
  final bool isOpen;
  const AmwalCheckOpening({required this.isOpen});
}
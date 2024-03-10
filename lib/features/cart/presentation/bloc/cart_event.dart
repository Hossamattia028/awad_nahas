import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';

@immutable
abstract class CartEvent{
  const CartEvent();
}

class FetchAllCartEvent extends CartEvent{
  const FetchAllCartEvent();
}

class AddToCartEvent extends CartEvent{
  final ProductsEntity? product;
  const AddToCartEvent({this.product,});
}

class RemoveToCartEvent extends CartEvent{
  final ProductsEntity product;
  const RemoveToCartEvent({required this.product});
}

class ModifyCartProductEvent extends CartEvent{
  final ProductsEntity? product;
  final bool isAdd;
  final BuildContext context;
  final bool remove;
  final int? count;
  const ModifyCartProductEvent({required this.product,required this.isAdd,required this.context,this.remove=false,this.count});
}

class UpdateShippingCostEvent extends CartEvent{
  final bool updateFromApi;
  const UpdateShippingCostEvent({this.updateFromApi=false});
}


class UpdateCouponContainerEvent extends CartEvent{
  final double height;
  final double width;
  const UpdateCouponContainerEvent({required this.width,required this.height});
}

class ImplementCouponDiscountEvent extends CartEvent{
  final String couponTxt;
  const ImplementCouponDiscountEvent({required this.couponTxt});
}

class UpdateCountEvent extends CartEvent{
  final int value;
  const UpdateCountEvent({required this.value});
}


class DeliveryWithInstallmentEvent extends CartEvent{
  final bool withInstallment;
  const DeliveryWithInstallmentEvent({required this.withInstallment});
}

class PaymentWithCardEvent extends CartEvent{
  final PaymentEnum paymentEnum;
  final bool? enableApplePay;
  const PaymentWithCardEvent({required this.paymentEnum,this.enableApplePay});
}


class UpdateCountBeforeInsertInCart extends CartEvent{
  final int value;
  const UpdateCountBeforeInsertInCart({required this.value});
}

class UpdateCountWidgetEvent extends CartEvent{
  final int? productId;
  const UpdateCountWidgetEvent({this.productId});
}

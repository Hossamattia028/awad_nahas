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
  final bool addAllCurrentList;
  const AddToCartEvent({this.product,this.addAllCurrentList=false});
}

class RemoveToCartEvent extends CartEvent{
  final ProductsEntity product;
  const RemoveToCartEvent({required this.product});
}

class UpdateCartProductEvent extends CartEvent{
  final ProductsEntity product;
  final bool isAdd;
  final BuildContext context;
  const UpdateCartProductEvent({required this.product,required this.isAdd,required this.context});
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

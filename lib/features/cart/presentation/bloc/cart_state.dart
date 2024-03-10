import 'package:flutter/material.dart';

@immutable
abstract class CartState {
  const CartState();
}

class CartInitialState extends CartState {
  const CartInitialState();
}

class CartLoadingState extends CartState {
  const CartLoadingState();
}

class CartSuccessfullyState extends CartState {
  const CartSuccessfullyState();
}

class AddToCartSuccessfullyState extends CartState {}

class RemoveCartSuccessfullyState extends CartState {}

class CartErrorState extends CartState {
  final String errors;

  const CartErrorState({required this.errors});
}

class CouponLoadingState extends CartState {
  const CouponLoadingState();
}

class CouponSuccessfullyState extends CartState {
  const CouponSuccessfullyState();
}

class DeliveryLoadingState extends CartState {}

class DeliverySuccessfullyState extends CartState {}

class PaymentLoadingState extends CartState {}

class PaymentSuccessfullyState extends CartState {}

class CountLoadingState extends CartState {}

class CountSuccessfullyState extends CartState {}

class CountWidgetLoadingState extends CartState {}

class CountWidgetSuccessfullyState extends CartState {}

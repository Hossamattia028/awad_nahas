
import 'package:flutter/material.dart';

@immutable
abstract class CartState{
  const CartState();
}



class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessfullyState extends CartState {}
class AddToCartSuccessfullyState extends CartState {}
class RemoveCartSuccessfullyState extends CartState {}


class CartErrorState extends CartState {
  final String errors;

  const CartErrorState({required this.errors});
}

class CouponLoadingState extends CartState {}
class CouponSuccessfullyState extends CartState {}
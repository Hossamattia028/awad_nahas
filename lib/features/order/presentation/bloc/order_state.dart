
import 'package:flutter/material.dart';

@immutable
abstract class OrderState{
  const OrderState();
}


class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessfullyState extends OrderState {}

class OrderTapSuccessfullyState extends OrderState {}

class OrderErrorState extends OrderState {
  final String errors;

  const OrderErrorState({required this.errors});
}


class ConfirmOrderSuccessfullyState extends OrderState {}

class AssignOrderSuccessfullyState extends OrderState {}
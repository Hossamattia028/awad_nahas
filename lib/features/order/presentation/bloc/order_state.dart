import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:flutter/material.dart';

@immutable
abstract class OrderState {
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

class SendPendingOrderSuccessfullyState extends OrderState {
  final String orderID;
  final PaymentOption payment;
  const SendPendingOrderSuccessfullyState({required this.orderID,required this.payment});
}

class AssignOrderSuccessfullyState extends OrderState {
    final PaymentOption payment;
    const AssignOrderSuccessfullyState({required this.payment});
}

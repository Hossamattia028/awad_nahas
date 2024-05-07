import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DealsState extends Equatable {
  const DealsState();

  @override
  List<Object?> get props => [];
}

class DealsInitialState extends DealsState {}

class DealsLoadingState extends DealsState {
  const DealsLoadingState();
}

class DealsSuccessfullyState extends DealsState {
  const DealsSuccessfullyState();
}

class DealsFailedState extends DealsState {
  const DealsFailedState();
}

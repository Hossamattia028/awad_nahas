
import 'package:flutter/material.dart';

@immutable
abstract class WishlistState{
  const WishlistState();
}



class WishlistInitialState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistSuccessfullyState extends WishlistState {}

class WishlistErrorState extends WishlistState {
  final String errors;

  const WishlistErrorState({required this.errors});
}


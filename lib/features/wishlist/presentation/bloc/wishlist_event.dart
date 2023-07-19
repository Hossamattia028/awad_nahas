import 'package:flutter/material.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';

@immutable
abstract class WishlistEvent{
  const WishlistEvent();
}




class FetchAllWishlistEvent extends WishlistEvent{
  const FetchAllWishlistEvent();
}

class AddToWishlistEvent extends WishlistEvent{
  final ProductsEntity product;
  const AddToWishlistEvent({required this.product});
}


class RemoveToWishlistEvent extends WishlistEvent{
  final ProductsEntity product;
  const RemoveToWishlistEvent({required this.product});
}
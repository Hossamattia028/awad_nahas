import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/cart/domain/entities/cart_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';

abstract class CartRepository{
  Future<Either<Failure,CartEntity>> getAllCartList();
  Future<Either<Failure,bool>> addCartItem({required Map<String,dynamic> data});
  Future<Either<Failure,bool>> removeCartItem({required int productID});
  Future<Either<Failure, ResCouponModel>> applyCoupon({required Map<String,dynamic> dataSet});
}
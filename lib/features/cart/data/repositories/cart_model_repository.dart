import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/core/network/network.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:awad_nahas/features/cart/domain/entities/cart_entity.dart';
import 'package:awad_nahas/features/cart/domain/repositories/cart_repository.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';

class CartModelRepository extends CartRepository{
  final CartRemoteDataSourceImpl cartRemoteDataSourceImpl;
  final NetworkInfo networkInfo;
  CartModelRepository(
      {required this.cartRemoteDataSourceImpl, required this.networkInfo});


  @override
  Future<Either<Failure, bool>> addCartItem({required Map<String,dynamic> data}) async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await cartRemoteDataSourceImpl.addCartItem(data: data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeCartItem({required int productID}) async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await cartRemoteDataSourceImpl.removeCartItem(productID: productID));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure,CartEntity>> getAllCartList() async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await cartRemoteDataSourceImpl.fetchAllCartList());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ResCouponModel>> applyCoupon({required Map<String,dynamic> dataSet}) async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await cartRemoteDataSourceImpl.applyCoupon(dataSet: dataSet));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }



}
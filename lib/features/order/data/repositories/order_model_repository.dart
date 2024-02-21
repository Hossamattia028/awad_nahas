

import 'package:awad_nahas/features/order/data/models/order_response.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/network/network.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';
import 'package:awad_nahas/features/order/domain/repositories/oder_repository.dart';

class OrderModelRepository implements OrderRepository {
  final OrderRemoteDataSourceImpl orderRemoteDataSource;
  final NetworkInfo networkInfo;
  OrderModelRepository({required this.orderRemoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<Orders>>> getAllOrders() async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await orderRemoteDataSource.getAllOrder());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, OrderResponse>> addOrder({required Map<String,dynamic> data}) async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await orderRemoteDataSource.addOrder(data: data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateOrder({required Map<String,dynamic> data}) async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await orderRemoteDataSource.updateOrder(data: data,));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrder({required int orderID}) async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await orderRemoteDataSource.cancelOrder(orderId: orderID));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}

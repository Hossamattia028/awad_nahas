
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/order/data/models/order_response.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';


abstract class OrderRepository {
  Future<Either<Failure, List<Orders>>> getAllOrders();
  Future<Either<Failure, OrderResponse>> addOrder({required Map<String,dynamic> data});
  Future<Either<Failure, bool>> updateOrder({required Map<String,dynamic> data});
  Future<Either<Failure, bool>> cancelOrder({required int orderID});
}

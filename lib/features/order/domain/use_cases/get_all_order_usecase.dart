import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';
import 'package:awad_nahas/features/order/domain/repositories/oder_repository.dart';

class GetAllOrderUseCase {
  final OrderRepository orderRepository;

  GetAllOrderUseCase({required this.orderRepository});

  Future<Either<Failure, List<Orders>>> call() async {
    return await orderRepository.getAllOrders();
  }
}

// class GetAllDriversOrdersUseCase {
//   final OrderRepository orderRepository;
//
//   GetAllDriversOrdersUseCase({required this.orderRepository});
//
//   Future<Either<Failure, List<Orders>>> call() async {
//     return await orderRepository.getAllDriversOrders();
//   }
// }

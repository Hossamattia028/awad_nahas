import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/order/domain/repositories/oder_repository.dart';

class CancelOrderUseCase {
  final OrderRepository orderRepository;

  CancelOrderUseCase({required this.orderRepository});

  Future<Either<Failure, bool>> call({required int orderId}) async {
     return await orderRepository.cancelOrder(orderID: orderId);
  }
}

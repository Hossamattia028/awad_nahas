
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/order/domain/repositories/oder_repository.dart';

class UpdateOrderUseCase {
  final OrderRepository orderRepository;

  UpdateOrderUseCase({required this.orderRepository});

  Future<Either<Failure, bool>> call({required Map<String,dynamic> data}) async {
    return await orderRepository.updateOrder(data: data);
  }
}

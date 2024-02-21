import 'package:awad_nahas/features/order/data/models/order_response.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/order/domain/repositories/oder_repository.dart';

class AddOrderUseCase {
  final OrderRepository orderRepository;

  AddOrderUseCase({required this.orderRepository});

  Future<Either<Failure, OrderResponse>> call({required Map<String,dynamic> data}) async {
    return await orderRepository.addOrder(data: data);
  }
}

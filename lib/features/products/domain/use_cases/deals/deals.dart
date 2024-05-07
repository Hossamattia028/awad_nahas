import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/products/domain/entities/deals_entity.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllProductsDealsUseCase {
  final ProductsRepository productsRepository;

  const GetAllProductsDealsUseCase({required this.productsRepository});

  Future<Either<Failure, List<DealsEntity>>> call() async {
    return await productsRepository.getAllProductsDeals();
  }
}
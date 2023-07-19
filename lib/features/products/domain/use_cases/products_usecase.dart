import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';

class GetAllProductsUseCase {
  final ProductsRepository productsRepository;

  GetAllProductsUseCase({required this.productsRepository});

  Future<Either<Failure, List<ProductsEntity>>> call({required String cat}) async {
    return await productsRepository.getAllProducts(cat: cat);
  }
}





import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';

class GetAllProductsUseCase {
  final ProductsRepository productsRepository;

  const GetAllProductsUseCase({required this.productsRepository});

  Future<Either<Failure, ProductResponseModel>> call({required String parameter}) async {
    return await productsRepository.getAllProducts(parameter: parameter);
  }
}





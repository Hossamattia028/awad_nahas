import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/products/data/models/product_small_model.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';

class GetAllProductCommentsUseCase {
  final ProductsRepository productsRepository;

  GetAllProductCommentsUseCase({required this.productsRepository});

  Future<Either<Failure, List<ProductComments>>> call({required Map<String,dynamic> data}) async {
    return await productsRepository.getAllProductComments(data: data);
  }
}


class AddProductCommentUseCase {
  final ProductsRepository productsRepository;

  AddProductCommentUseCase({required this.productsRepository});

  Future<Either<Failure, bool>> call({required Map<String,dynamic> data}) async {
    return await productsRepository.addProductComment(data: data);
  }
}





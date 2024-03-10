import 'package:awad_nahas/features/products/data/models/product_comments.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';

class GetAllProductCommentsUseCase {
  final ProductsRepository productsRepository;

  const GetAllProductCommentsUseCase({required this.productsRepository});

  Future<Either<Failure, List<ProductComments>>> call({required Map<String,dynamic> data}) async {
    return await productsRepository.getAllProductComments(data: data);
  }
}


class AddProductCommentUseCase {
  final ProductsRepository productsRepository;

  const AddProductCommentUseCase({required this.productsRepository});

  Future<Either<Failure, bool>> call({required Map<String,dynamic> data}) async {
    return await productsRepository.addProductComment(data: data);
  }
}





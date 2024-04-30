import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/products/data/models/product_comments.dart';
import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:awad_nahas/features/products/domain/entities/deals_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ProductResponseModel>> getAllProducts({required String parameter});
  Future<Either<Failure, List<ProductComments>>> getAllProductComments({required Map<String,dynamic> data});
  Future<Either<Failure, bool>> addProductComment({required Map<String,dynamic> data});

  Future<Either<Failure, List<DealsEntity>>> getAllProductsDeals();
}

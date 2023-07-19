import 'package:awad_nahas/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/products/data/models/product_small_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductsEntity>>> getAllProducts({required String cat});
  Future<Either<Failure, List<ProductsEntity>>> getAllProductsByVendor({required int vendorID});
  Future<Either<Failure, List<ProductComments>>> getAllProductComments({required Map<String,dynamic> data});
  Future<Either<Failure, bool>> addProductComment({required Map<String,dynamic> data});
}

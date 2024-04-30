import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/network/network.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:awad_nahas/features/products/data/models/product_comments.dart';
import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:awad_nahas/features/products/domain/entities/deals_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';



class ProductsModelRepository implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;
  final NetworkInfo networkInfo;
  ProductsModelRepository(
      {required this.productsRemoteDataSource, required this.networkInfo});


  @override
  Future<Either<Failure, ProductResponseModel>> getAllProducts({required String parameter}) async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await productsRemoteDataSource.getAllProducts(parameter: parameter));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addProductComment({required Map<String, dynamic> data})async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await productsRemoteDataSource.addProductComment(data: data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductComments>>> getAllProductComments({required Map<String, dynamic> data})async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await productsRemoteDataSource.getAllProductComments(data: data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<DealsEntity>>> getAllProductsDeals() async{
   if (await networkInfo.isConnected()) {
      try {
        return Right(await productsRemoteDataSource.getAllProductsDeals());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }




}

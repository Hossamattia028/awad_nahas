import 'package:awad_nahas/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';

abstract class FavouriteRepository{
  Future<Either<Failure,List<ProductsEntity>>> getAllFavouriteList();
  Future<Either<Failure,bool>> addFavouriteItem({required Map<String,dynamic> data});
  Future<Either<Failure,bool>> removeFavouriteItem({required Map<String,dynamic> data});
}
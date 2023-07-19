import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/core/network/network.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/wishlist/data/data_sources/favourite_remote_data_source.dart';
import 'package:awad_nahas/features/wishlist/domain/repositories/favourite_repository.dart';

class FavouriteModelRepository extends FavouriteRepository{
  final FavouriteRemoteDataSourceImpl favouriteRemoteDataSourceImpl;
  final NetworkInfo networkInfo;
  FavouriteModelRepository(
      {required this.favouriteRemoteDataSourceImpl, required this.networkInfo});


  @override
  Future<Either<Failure, bool>> addFavouriteItem({required Map<String,dynamic> data}) async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await favouriteRemoteDataSourceImpl.addFavouriteItem(data: data,));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavouriteItem({required int favID}) async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await favouriteRemoteDataSourceImpl.removeFavouriteItem(favID: favID));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductsEntity>>> getAllFavouriteList() async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await favouriteRemoteDataSourceImpl.fetchAllFavourites());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }



}
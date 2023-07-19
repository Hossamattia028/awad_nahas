import 'package:awad_nahas/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/wishlist/domain/repositories/favourite_repository.dart';

class GetAllFavouritesUseCase{
  final FavouriteRepository favouriteRepository;
  const GetAllFavouritesUseCase({required this.favouriteRepository});

  Future<Either<Failure,List<ProductsEntity>>> call() async{
    return await favouriteRepository.getAllFavouriteList();
  }
}

class AddFavouriteItemUseCase{
  final FavouriteRepository favouriteRepository;
  const AddFavouriteItemUseCase({required this.favouriteRepository});

  Future<Either<Failure,bool>> call({required Map<String,dynamic> data}) async{
    return await favouriteRepository.addFavouriteItem(data: data,);
  }
}

class RemoveFavouriteItemUseCase{
  final FavouriteRepository favouriteRepository;
  const RemoveFavouriteItemUseCase({required this.favouriteRepository});

  Future<Either<Failure,bool>> call({required int favID,}) async{
    return await favouriteRepository.removeFavouriteItem(favID: favID,);
  }
}
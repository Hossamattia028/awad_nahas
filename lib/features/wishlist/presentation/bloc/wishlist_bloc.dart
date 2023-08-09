import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/wishlist/domain/use_cases/favourite_usecase.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_state.dart';


class WishlistBloc extends Bloc<WishlistEvent,WishlistState>{
  List<ProductsEntity> wishlistList = [];
  int currentCategoryIndex = 0;
  GetAllFavouritesUseCase getAllFavouritesUseCase;
  AddFavouriteItemUseCase addFavouriteItemUseCase;
  RemoveFavouriteItemUseCase removeFavouriteItemUseCase;
  WishlistBloc({
    required this.getAllFavouritesUseCase,
    required this.addFavouriteItemUseCase,
    required this.removeFavouriteItemUseCase,
}) : super(WishlistInitialState()) {

    on<FetchAllWishlistEvent>((event, emit) async{
       await getAllWishlist(emit);
    });

    on<AddToWishlistEvent>((event, emit) async {
      await addNewWishlist(event,emit);
      await getAllWishlist(emit);
    });

    on<RemoveToWishlistEvent>((event, emit) async {
      await removeWishlist(event,emit);
      await getAllWishlist(emit);
    });

  }

  static WishlistBloc get(BuildContext context) => BlocProvider.of(context);


  getAllWishlist(emit)async{
    if(!Util.checkUser())return;
    emit(WishlistLoadingState());
    try{
      var res = await getAllFavouritesUseCase();
      res.fold((l) {
        emit(WishlistErrorState(errors: l.toString()));
      },(data) {
        wishlistList = data.reversed.toList();
        emit(WishlistSuccessfullyState());
      });
    }catch(e){
      emit(WishlistErrorState(errors: e.toString()));
    }
  }


  addNewWishlist(AddToWishlistEvent event,emit)async{
    if(!Util.checkUser())return;
    emit(WishlistLoadingState());
    try{
      var res = await addFavouriteItemUseCase(data: {'product_id':event.product.id});
      res.fold((l) {
        emit(WishlistErrorState(errors: l.toString()));
      },(data) {
        emit(WishlistSuccessfullyState());
      });
      emit(WishlistSuccessfullyState());
    }catch(e){
      emit(WishlistErrorState(errors: e.toString()));
    }
  }


  removeWishlist(RemoveToWishlistEvent event,emit)async{
    emit(WishlistLoadingState());
    // try{
      var res = await removeFavouriteItemUseCase(data: {'product_id':event.product.id});
      res.fold((l) {
        emit(WishlistErrorState(errors: l.toString()));
      },(data) {
        emit(WishlistSuccessfullyState());
      });
      emit(WishlistSuccessfullyState());
    // }catch(e){
    //   emit(WishlistErrorState(errors: e.toString()));
    // }
  }



}
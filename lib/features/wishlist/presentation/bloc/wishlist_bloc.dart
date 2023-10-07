import 'dart:convert';

import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/products/data/models/product_small_model.dart';
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
      // await getAllWishlist(emit);
    });

    on<RemoveToWishlistEvent>((event, emit) async {
      await removeWishlist(event,emit);
      await getAllWishlist(emit);
    });

  }

  static WishlistBloc get(BuildContext context) => BlocProvider.of(context);


  getAllWishlist(emit)async{
    emit(WishlistLoadingState());
    try{
      wishlistList = _getLocalWishList();
      // var res = await getAllFavouritesUseCase();
      // res.fold((l) {
      //   emit(WishlistErrorState(errors: l.toString()));
      // },(data) {
      //   wishlistList = data.reversed.toList();
      //   emit(WishlistSuccessfullyState());
      // });
      emit(WishlistSuccessfullyState());
    }catch(e){
      debugPrint("getAllWishlistError: $e");
      emit(WishlistErrorState(errors: e.toString()));
    }
  }

  List<ProductModel> _getLocalWishList(){
    if(!SharedPref().containPreference(Constants.allLocalWishList))return [];
    String data =  SharedPref().getPreferenceString(Constants.allLocalWishList);
    List<dynamic> decodedList = json.decode(data);
    List<ProductModel> list = decodedList
        .map((product) => ProductModel.fromJsonLocal(product))
        .toList();
    return list;
  }


  addNewWishlist(AddToWishlistEvent event,emit)async{
    emit(WishlistLoadingState());
    try{
      int index = wishlistList.indexWhere((element) => event.product.id==element.id || event.product.imgPath==element.imgPath);
      if(index!=-1){
        wishlistList.removeAt(index);
        updateWishList(wishlistList);
      }else{
        wishlistList.add(event.product);
        updateWishList(wishlistList);
      }
      // var res = await addFavouriteItemUseCase(data: {'product_id':event.product.id});
      // res.fold((l) {
      //   emit(WishlistErrorState(errors: l.toString()));
      // },(data) {
      //   emit(WishlistSuccessfullyState());
      // });
      emit(WishlistSuccessfullyState());
    }catch(e){
      debugPrint("addNewWishlistError: $e");
      emit(WishlistErrorState(errors: e.toString()));
    }
  }

  updateWishList(List<ProductsEntity> list){
    SharedPref().removePreference(Constants.allLocalWishList);
    String encodedList = json.encode(list
        .map((product) => ProductModel.toJsonLocal(product))
        .toList());
    SharedPref().setPreferencesString(Constants.allLocalWishList,encodedList);
    wishlistList = _getLocalWishList();
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
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/wishlist/domain/use_cases/favourite_usecase.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_state.dart';


class WishlistBloc extends Bloc<WishlistEvent,WishlistState>{
  List<ProductsEntity> wishlistList = [
    const ProductsEntity(title: "Smeg 50’s Style Retro Aesthetic", catTitle: "Small Appliances", desc: "Small Appliances", id: 0,
        imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/smeg.png?alt=media&token=9c98c424-0525-49dc-beeb-6900acfedf35",
        price: 200, discount: 20, discountRate: 20, stockStatus: true, quantity: 2, categoryList: [
          CategoriesEntity(title: "Cooker Hobs", id: 0, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
        ], commentCount: 20),
    const ProductsEntity(title: "Smeg 50’s Style Retro Aesthetic", catTitle: "Small Appliances", desc: "Small Appliances", id:1,
        imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/smeg.png?alt=media&token=9c98c424-0525-49dc-beeb-6900acfedf35",
        price: 200, discount: 20, discountRate: 20, stockStatus: true, quantity: 2, categoryList: [
          CategoriesEntity(title: "Cooker Hobs", id: 0, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
        ], commentCount: 20),
  ];


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
    emit(WishlistLoadingState());
    // try{
      var res = await getAllFavouritesUseCase();
      res.fold((l) {
        emit(WishlistErrorState(errors: l.toString()));
      },(data) {
        wishlistList = data.reversed.toList();
        emit(WishlistSuccessfullyState());
      });
    // }catch(e){
    //   emit(WishlistErrorState(errors: e.toString()));
    // }
  }

  List<Map<String,dynamic>> returnNewWishList(ProductsEntity item,emit){
    List<Map<String,dynamic>> list = [];
    int index = wishlistList.indexWhere((element) => element.id==item.id);
    if(index!=-1) {
      wishlistList.removeAt(index);
    }else{
      wishlistList.add(item);
    }
    for(var i in wishlistList){
      list.add({'product_ID':i.id,'on_sale':"1"});
    }
    return list;
  }

  addNewWishlist(AddToWishlistEvent event,emit)async{
    emit(WishlistLoadingState());
    try{
      var res = await addFavouriteItemUseCase(data: {'fav_list':returnNewWishList(event.product,emit)});
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
      var res = await removeFavouriteItemUseCase(favID: event.product.id);
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
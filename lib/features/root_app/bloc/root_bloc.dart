import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  List<ProductsEntity> productSearchList = [
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
    const ProductsEntity(title: "Smeg 50’s Style Retro Aesthetic", catTitle: "Small Appliances", desc: "Small Appliances", id:1,
        imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/smeg.png?alt=media&token=9c98c424-0525-49dc-beeb-6900acfedf35",
        price: 200, discount: 20, discountRate: 20, stockStatus: true, quantity: 2, categoryList: [
          CategoriesEntity(title: "Cooker Hobs", id: 0, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
        ], commentCount: 20),
    const ProductsEntity(title: "Smeg 50’s Style Retro Aesthetic", catTitle: "Small Appliances", desc: "Small Appliances", id: 0,
        imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/smeg.png?alt=media&token=9c98c424-0525-49dc-beeb-6900acfedf35",
        price: 200, discount: 20, discountRate: 20, stockStatus: true, quantity: 2, categoryList: [
          CategoriesEntity(title: "Cooker Hobs", id: 0, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
        ], commentCount: 20),
  ];
  List<CategoriesEntity> categorySearchList = const [
    CategoriesEntity(title: "Cooker Hobs", id: 0, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
    CategoriesEntity(title: "Ovens", id: 1, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
  ];
  int currentScreenIndex = 0;
  String currentScreenTitle = translate("home.home");
  static RootBloc get(BuildContext context) => BlocProvider.of(context);
  RootBloc() : super(RootInitialState()) {
    on<ChangeIndex>((event, emit) {
      currentScreenIndex = event.index;
      currentScreenTitle = event.title;
      emit(RootSuccessState());
    });

    on<ChangeCurrentCurrency>((event, emit) {
      changeCurrentCurrency(event,emit);
    });

    on<SearchEvent>((event, emit) async{
      await searchProductsAndCategories(event,emit);
    });
  }


  changeCurrentCurrency(event,emit){
    emit(RootSuccessState());
  }


  searchProductsAndCategories(SearchEvent event,emit)async{
    // try{
    emit(RootLoadingState());
    if(event.word.toString().trim()==""){
      // categorySearchList.clear();
      // productSearchList.clear();
      emit(RootSuccessState());
      return;
    }
    // categorySearchList = searchCategories(event.word,event.categoryList);
    // productSearchList = searchProducts(event.word,event.productList);
    emit(RootSuccessState());
    // }catch(e){
    //   emit(RootErrorState(errors: e.toString()));
    //   debugPrint("searchProductsAndCategories: $e");
    // }
  }


  List searchCategories(String word,List<CategoriesEntity> list){
    try{
      return list.where((element) => element.title.toString().toLowerCase().startsWith(word)).toList();
    }catch(e){
      debugPrint("searchProductsAndCategories: $e");
      return [];
    }
  }

  List searchProducts(String word,List<ProductsEntity> list){
    try{
      return list.where((element) => element.title.toString().toLowerCase().startsWith(word)).toList();
    }catch(e){
      debugPrint("searchProductsAndCategories: $e");
      return [];
    }
  }





}

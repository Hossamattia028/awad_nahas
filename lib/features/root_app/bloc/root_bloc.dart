import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  List<ProductsEntity> productSearchList = [];
  List<CategoriesEntity> categorySearchList =  const[];
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

    on<EnableSearchEvent>((event, emit)async{
      modifySearchAvailability(event,emit);
    });
  }


  changeCurrentCurrency(event,emit){
    emit(RootSuccessState());
  }


  searchProductsAndCategories(SearchEvent event,emit)async{
    try{
    emit(RootLoadingState());
    if(event.word.toString().trim()==""){
      enableSearch = false;
      categorySearchList.clear();
      productSearchList.clear();
      emit(RootSuccessState());
      return;
    }
    categorySearchList = searchCategories(event.word,event.categoryList);
    productSearchList = searchProducts(event.word,event.productList);
    enableSearch = true;
    emit(RootSuccessState());
    }catch(e){
      emit(RootErrorState(errors: e.toString()));
      debugPrint("searchProductsAndCategories: $e");
    }
  }


  List<CategoriesEntity> searchCategories(String word,List<CategoriesEntity> list){
    try{
      return list.where((element) => element.title.toString().toLowerCase().startsWith(word)).toList();
    }catch(e){
      debugPrint("searchProductsAndCategories: $e");
      return [];
    }
  }


  // WARNING
  /// this function will be edit later
  List<ProductsEntity> searchProducts(String word,List<ProductsEntity> list){
    List<ProductsEntity> thisList  = [];
    try{
      var firstList = list.getRange(0, list.length~/2).toList();
      thisList.addAll(firstList.where((element) => element.title.toString().toLowerCase().startsWith(word)).toList());
      Future.delayed(const Duration(seconds: 3),(){
        var secondList =  list.getRange(list.length~/2, list.length).toList();
        thisList.addAll(secondList.where((element) => element.title.toString().toLowerCase().startsWith(word)).toList());
      });
      return thisList;
    }catch(e){
      debugPrint("searchProductsAndCategories: $e");
      return [];
    }
  }



  bool enableSearch = false;
  modifySearchAvailability(EnableSearchEvent event,emit){
    emit(RootInitialState());
    enableSearch = !enableSearch;
    emit(RootSuccessState());
  }



}

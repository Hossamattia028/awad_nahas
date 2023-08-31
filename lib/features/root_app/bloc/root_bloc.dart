import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/setting/data/data_sources/settings_remote_data_source.dart';
import 'package:awad_nahas/features/setting/data/models/faqs_model.dart';
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


    on<FetchSettingEvent>((event, emit)async{
      await getAllSetting(event,emit);
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
    productSearchList = await searchProducts(event.word,event.productList,emit);
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
  Future searchProducts(String word,List<ProductsEntity> list,emit)async{
    List<ProductsEntity> thisList  = [];
    try{
      var firstList = list.getRange(0, list.length~/2).toList();
      thisList.addAll(firstList.where((element) => element.title.toString().toLowerCase().startsWith(word)).toList());
      productSearchList = thisList;
      enableSearch = true;
      emit(RootSuccessState());
      await Future.delayed(const Duration(seconds: 2),(){
        var secondList =  list.getRange(list.length~/2, list.length).toList();
        thisList.addAll(secondList.where((element) => element.title.toString().toLowerCase().startsWith(word)).toList());
        productSearchList.addAll(thisList);
        emit(RootSuccessState());
      });
    }catch(e){
      debugPrint("searchProductsAndCategories: $e");
      return [];
    }
  }



  bool enableSearch = false;
  modifySearchAvailability(EnableSearchEvent event,emit){
    emit(RootInitialState());
    if(event.enable!=null){
      enableSearch = event.enable!;
    }else{
      enableSearch = !enableSearch;
    }
    if(event.productList!=null)productSearchList = event.productList!;
    emit(RootSuccessState());
  }



  getAllSetting(event,emit)async{
    await getLocations();
    await getFaqs();
    emit(RootSuccessState());
  }

  /// our locations
  List<LocationModel> ourLocations = [];
  getLocations()async{
    try{
      ourLocations = await SettingsRemoteDataSource.getOurLocations();
    }catch(e){
      debugPrint("getLocationsRootBloc: $e");
    }
  }

  List<FaqsModel> ourFaqs = [];
  getFaqs()async{
    try{
      ourFaqs = await SettingsRemoteDataSource.getOurFaqs();
    }catch(e){
      debugPrint("getFaqsRootBloc: $e");
    }
  }



}

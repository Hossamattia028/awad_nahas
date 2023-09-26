import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
import 'package:awad_nahas/core/strings/enum/filter_enum.dart';
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

    on<ChangeDrawerViewEvent>((event, emit)async{
      changeDrawerView(event,emit);
    });


    on<FetchSettingEvent>((event, emit)async{
      await getAllSetting(event,emit);
    });

    on<SendMaintenanceEvent>((event, emit)async{
      await sendMaintenance(event,emit);
    });

    on<UpdateSearchProductList>((event, emit){
      updateProductSearchList(event,emit);
    });

  }


  DrawerEnum drawerEnum = DrawerEnum.MAIN;
  changeDrawerView(ChangeDrawerViewEvent event,emit){
    emit(RootLoadingState());
    drawerEnum = event.drawerEnum;
    emit(RootSuccessState());
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
      await searchProducts(event.word,event.productList,emit);
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
      thisList.addAll(firstList.where((element) => element.title.toString().toLowerCase().startsWith(word) || element.sku.toString().toLowerCase().startsWith(word)).toList());
      productSearchList = thisList;
      enableSearch = true;
      emit(RootSuccessState());
      await Future.delayed(const Duration(seconds: 2),(){
        var secondList =  list.getRange(list.length~/2, list.length).toList();
        thisList.addAll(secondList.where((element) => element.title.toString().toLowerCase().startsWith(word) || element.sku.toString().toLowerCase().startsWith(word)).toList());
        productSearchList.addAll(thisList.toList());
        productSearchList = [...{...productSearchList}];
        emit(RootSuccessState());
      });
    }catch(e){
      debugPrint("searchProducts: $e");
      return [];
    }
  }

  updateProductSearchList(UpdateSearchProductList event,emit){
    emit(RootLoadingState());
    if(event.productList!=null)productSearchList = event.productList!;
    if(event.sortEnum!=null)productSearchList = sortProducts(event.sortEnum!, productSearchList);
    emit(RootSuccessState());
  }

  List<ProductsEntity> sortProducts(SortEnum sortType,List<ProductsEntity> list){
    if(sortType == SortEnum.NEW){
      list.sort((a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
    }else if(sortType == SortEnum.PRICE_HIGH_TO_LOW){
      list.sort((a, b) => b.price.compareTo(a.price));
    }else if(sortType == SortEnum.PRICE_LOW_TO_HIGH){
      list.sort((a, b) => a.price.compareTo(b.price));
    }else if(sortType == SortEnum.AVERAGE_RATE){
      list.sort((a, b) => double.parse(b.averageRate.toString()).compareTo(double.parse(a.averageRate.toString())));
    }else{
      list = list;
    }
    return list;
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
    emit(RootLoadingState());
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

  /// faqs
  List<FaqsModel> ourFaqs = [];
  getFaqs()async{
    try{
      ourFaqs = await SettingsRemoteDataSource.getOurFaqs();
    }catch(e){
      debugPrint("getFaqsRootBloc: $e");
    }
  }

  /// maintenance

  sendMaintenance(SendMaintenanceEvent event,emit)async{
    try{
      emit(MaintenanceLoadingState());
      bool check = await SettingsRemoteDataSource.sendMaintenanceRequest(event.data);
      if(check){
        emit(MaintenanceSuccessState());
      }else{
        emit(MaintenanceErrorState());
      }
    }catch(e){
      debugPrint("sendMaintenanceRootBloc: $e");
    }
  }


}

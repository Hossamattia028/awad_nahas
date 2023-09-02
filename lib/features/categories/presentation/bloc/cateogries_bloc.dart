import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/domain/entities/slider_entity.dart';
import 'package:awad_nahas/features/categories/domain/use_cases/get_all_categories_usecase.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/screens/category_products.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String testImg = "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/main-banner.png?alt=media&token=37aa3289-a748-4413-83f4-0b79a006006c";

class CategoriesBloc extends Bloc<CategoriesEvent,CategoriesState>{
  CategoriesEntity? currentCategory;

  /// store the categories list to can convert title when switch the language
  List<CategoriesEntity> categoriesList = [];
  List<CategoriesEntity> brandsList = [];

  CategoriesEntity? currentSubCategory;
  List<CategoriesEntity> subCategoriesList =  [];

  CategoriesEntity? currentBrand;

  GetAllCategoryUseCase getAllCategoryUseCase;
  GetAllBrandsUseCase getAllBrandsUseCase;
  GetAllSlidersUseCase getAllSlidersUseCase;
  CategoriesBloc({
    required this.getAllCategoryUseCase,
    required this.getAllBrandsUseCase,
    required this.getAllSlidersUseCase,
  }) : super(CategoriesInitialState()) {
    on<ChangeCategoriesEvent>((event, emit) {
      changeCurrentCategory(event,emit);
    });

    on<ChangeSubCategoriesEvent>((event, emit) {
      changeCurrentSubCategory(event,emit);
    });

    on<UpdateCategoriesLangEvent>((event, emit) {

    });

    on<FetchAllCategoriesEvent>((event, emit) async{
      await getAllCategories(emit);
    });

    on<FetchAllBrandsEvent>((event, emit) async{
      await getAllBrands(emit);
    });

    on<SetProductsToCategoryEvent>((SetProductsToCategoryEvent event, emit) async{
      await setProductListToCategory(event,emit);
    });

    on<ChangeSliderIndexEvent>((event, emit) {
      changeCurrentSlider(event,emit);
    });


    on<FetchMainSlidersEvent>((event, emit)async{
      await getAllSliders(emit);
    });

    on<FetchAnotherSliderAdsEvent>((event, emit)async{

    });

    on<ChangeCurrentBrand>((event, emit) {
      setCurrentBrand(event, emit);
    });
    on<ChangeBrandIndexEvent>((event, emit) {
      changeCurrentBrandIndex(event, emit);
    });
  }
  static CategoriesBloc get(BuildContext context) => BlocProvider.of(context);

  /// slider section
  List<SliderEntity> mainSlider = [];
  List<SliderEntity> anotherSliders = [];
  int currentSliderIndex = 0;
  changeCurrentSlider(event,emit){
    emit(FetchSliderLoadingState());
    currentSliderIndex = event.val;
    emit(FetchSliderSuccessfullyState());
  }

  getAllSliders(emit)async{
    emit(FetchSliderLoadingState());
    try{
     var res = await getAllSlidersUseCase();
     res.fold((l) {
       emit(FetchSliderFailedState());
     },(data) {
       mainSlider = data.where((element) => element.kind == "slider").toList();
       anotherSliders = data.where((element) => element.kind != "slider").toList();
       emit(FetchSliderSuccessfullyState());
     });
    }catch(e){
      debugPrint("getAllSlidersBlocError: $e");
      emit(FetchSliderFailedState());
    }
  }

  filterSliderByLang(List<SliderEntity> sliders){
    if(Util.getLang()=="ar"){
      return sliders.where((element) => element.title.toString().toLowerCase().contains("ar")).toList();
    }else{
      return sliders.where((element) => element.title.toString().toLowerCase().contains("en")).toList();
    }
  }

  goSliderPath(SliderEntity slider,BuildContext context){
    if(slider.type=="cat"){
      var list = categoriesList;
      int index = list.indexWhere((element) => element.id.toString()==slider.typeID.trim());
      if(index==-1)return;
      CategoriesBloc.get(context).add(ChangeCategoriesEvent(categoriesModel: list[index]));
      Util.pushPage(const CategoryProductsScreen(), context);
    }else if(slider.type=="product"){
      var list = ProductsBloc.get(context).productsList;
      int index = list.indexWhere((element) => element.id.toString()==slider.typeID.trim());
      if(index==-1)return;
      Util.pushPage(ProductDetailPage(item: list[index],), context);
    }
  }


  /// categories section
  changeCurrentCategory(ChangeCategoriesEvent event,emit){
    emit(CategoriesInitialState());
    currentCategory = event.categoriesModel;
    currentSubCategory = null;
    emit(CategoriesIndexChangedSuccessState());
  }

  getAllCategories(emit)async{
    // emit(const FetchCategoriesLoadingState());
    // try{
      var res = await getAllCategoryUseCase();
      res.fold((l) {
        emit(const FetchCategoriesFailedState());
      },(data) {
        // storedCategoriesList = data;
        categoriesList = data.where((element) => element.parentID=="0" && (!element.imgPath.toString().contains("{s:")) && element.imgPath.toString().trim()!="").toList();
        subCategoriesList = data.where((element) => element.parentID!="0").toList();
      });
      emit(const FetchCategoriesSuccessfullyState());
    // }catch(e){
    //   debugPrint("getAllCategoriesBlocError: $e");
    //   emit(const FetchCategoriesFailedState());
    // }
  }

  getAllBrands(emit)async{
    // emit(const FetchCategoriesLoadingState());
    // try{
      var res = await getAllBrandsUseCase();
      res.fold((l) {
        emit(const FetchCategoriesFailedState());
      },(data) {
        brandsList = data;
      });
      emit(const FetchCategoriesSuccessfullyState());
    // }catch(e){
    //   debugPrint("getAllBrandsBlocError: $e");
    //   emit(const FetchCategoriesFailedState());
    // }
  }

  setProductListToCategory(SetProductsToCategoryEvent event,emit){
    int index = categoriesList.indexWhere((element) => event.catID==element.id);
    if(index!=-1){
      // categoriesList[index].productList = event.list;
      emit(CategoriesIndexChangedSuccessState());
    }
  }

  List getCurrentCategoryProductList(int catID){
    // int index = categoriesList.indexWhere((element) => catID==element.id);
    // if(index!=-1 && categoriesList[index].productList!=null && categoriesList[index].productList!.isNotEmpty)return categoriesList[index].productList!;
    return [];
  }


  /// categories section
  changeCurrentSubCategory(ChangeSubCategoriesEvent event,emit){
    emit(CategoriesInitialState());
    currentSubCategory = event.categoriesModel;
    emit(CategoriesIndexChangedSuccessState());
  }

  updateCategories(UpdateCategoriesLangEvent event,emit){
    emit(CategoriesInitialState());
    // activateTransList();
    emit(CategoriesIndexChangedSuccessState());
  }

  activateTransList(List<CategoriesEntity> list){
    if(Util.getLang()=="ar"){
      return list.where((element) => element.isArabic==true).toList();
    }else{
      return list.where((element) => element.isArabic==false).toList();
    }
  }





  /// brands section
  setCurrentBrand(ChangeCurrentBrand event,emit){
    emit(CategoriesInitialState());
    currentBrand = event.brandModel;
    currentBrandIndex = 0;
    emit(ChangeCurrentBrandSuccessState());
  }

  int currentBrandIndex = 0;
  changeCurrentBrandIndex(ChangeBrandIndexEvent event,emit){
    emit(CategoriesInitialState());
    currentBrandIndex = event.index;
    emit(ChangeCurrentBrandSuccessState());
  }
}
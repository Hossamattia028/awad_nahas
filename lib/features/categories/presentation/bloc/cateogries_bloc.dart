import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/data/models/photo_model.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/domain/entities/slider_entity.dart';
import 'package:awad_nahas/features/categories/domain/use_cases/get_all_categories_usecase.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String testImg = "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/main-banner.png?alt=media&token=37aa3289-a748-4413-83f4-0b79a006006c";

class CategoriesBloc extends Bloc<CategoriesEvent,CategoriesState>{
  CategoriesEntity? currentCategory;

  /// store the categories list to can convert title when switch the language
  List<CategoriesEntity> storedCategoriesList = [];
  List<CategoriesEntity> categoriesList = [];

  CategoriesEntity? currentSubCategory;
  List<CategoriesEntity> subCategoriesList = const [];

  CategoriesEntity? currentBrand;
  List<CategoriesEntity> brandList = const [];

  GetAllCategoryUseCase getAllCategoryUseCase;
  GetAllSlidersUseCase getAllSlidersUseCase;
  CategoriesBloc({
    required this.getAllCategoryUseCase,
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

  List<PhotoModel> mainSlider = [
    const PhotoModel(status: true, id: 0, imgUrl: testImg),
    const PhotoModel(status: true, id: 0, imgUrl: testImg),
    const PhotoModel(status: true, id: 0, imgUrl: testImg),
    const PhotoModel(status: true, id: 0, imgUrl: testImg),
    const PhotoModel(status: true, id: 0, imgUrl: testImg),
  ];

  SliderEntity? categorySlider;
  SliderEntity? cartSlider;

  int currentSliderIndex = 0;
  changeCurrentSlider(event,emit){
    emit(FetchSliderLoadingState());
    currentSliderIndex = event.val;
    emit(FetchSliderSuccessfullyState());
  }

  getAllSliders(emit)async{
    emit(FetchSliderLoadingState());
    try{
    //   await _downloadCustomizeSlider(sliderEnum: SliderEnum.l_s_0,list: ls0Slider,emit: emit);
    }catch(e){
      debugPrint("getAllSlidersBlocError: $e");
      emit(FetchSliderFailedState());
    }
  }



  /// categories section
  changeCurrentCategory(ChangeCategoriesEvent event,emit){
    emit(CategoriesInitialState());
    currentCategory = event.categoriesModel;
    // currentSubCategory = subCategoriesList.first;
    emit(CategoriesIndexChangedSuccessState());
  }

  getAllCategories(emit)async{
    // emit(const FetchCategoriesLoadingState());
    try{
      var res = await getAllCategoryUseCase();
      res.fold((l) {
        emit(const FetchCategoriesFailedState());
      },(data) {
        storedCategoriesList = data;
        _activateTransList();
      });
      emit(const FetchCategoriesSuccessfullyState());
    }catch(e){
      debugPrint("getAllCategoriesBlocError: $e");
      emit(const FetchCategoriesFailedState());
    }
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
    _activateTransList();
    emit(CategoriesIndexChangedSuccessState());
  }

  _activateTransList(){
    if(Util.getLang()=="ar"){
      categoriesList = storedCategoriesList.where((element) => element.isArabic==true).toList();
    }else{
      categoriesList = storedCategoriesList.where((element) => element.isArabic==false).toList();
    }
  }





  /// brands section
  setCurrentBrand(ChangeCurrentBrand event,emit){
    currentBrand = event.brandModel;
    emit(ChangeCurrentBrandSuccessState());
  }

  int currentBrandIndex = 0;
  changeCurrentBrandIndex(ChangeBrandIndexEvent event,emit){
    emit(CategoriesInitialState());
    currentBrandIndex = event.index;
    emit(ChangeCurrentBrandSuccessState());
  }
}
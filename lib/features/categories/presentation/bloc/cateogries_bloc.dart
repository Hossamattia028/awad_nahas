import 'package:awad_nahas/features/categories/data/models/photo_model.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/domain/entities/slider_entity.dart';
import 'package:awad_nahas/features/categories/domain/use_cases/get_all_categories_usecase.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CategoriesBloc extends Bloc<CategoriesEvent,CategoriesState>{
  List<CategoriesEntity> categoriesList = const [
    CategoriesEntity(title: "Cooker Hobs", id: 0, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
    CategoriesEntity(title: "Ovens", id: 1, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
    CategoriesEntity(title: "Refrigerations", id: 2, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
    CategoriesEntity(title: "Cooker Hobs", id: 3, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
  ];

  GetAllCategoryUseCase getAllCategoryUseCase;
  GetAllSlidersUseCase getAllSlidersUseCase;
  CategoriesBloc({
    required this.getAllCategoryUseCase,
    required this.getAllSlidersUseCase,
  }) : super(CategoriesInitialState()) {
    on<ChangeCategoriesEvent>((event, emit) {
      // currentCategoryModel = event.categoriesModel;
      emit(CategoriesIndexChangedSuccessState());
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
  }
  static CategoriesBloc get(BuildContext context) => BlocProvider.of(context);

  List<PhotoModel> mainSlider = [
    const PhotoModel(status: true, id: 0, imgUrl: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/main-banner.png?alt=media&token=37aa3289-a748-4413-83f4-0b79a006006c"),
    const PhotoModel(status: true, id: 0, imgUrl: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/main-banner.png?alt=media&token=37aa3289-a748-4413-83f4-0b79a006006c"),
    const PhotoModel(status: true, id: 0, imgUrl: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/main-banner.png?alt=media&token=37aa3289-a748-4413-83f4-0b79a006006c"),
    const PhotoModel(status: true, id: 0, imgUrl: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/main-banner.png?alt=media&token=37aa3289-a748-4413-83f4-0b79a006006c"),
    const PhotoModel(status: true, id: 0, imgUrl: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/main-banner.png?alt=media&token=37aa3289-a748-4413-83f4-0b79a006006c"),
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




  getAllCategories(emit)async{
    emit(const FetchCategoriesLoadingState());
    try{
      var res = await getAllCategoryUseCase();
      res.fold((l) {
        emit(const FetchCategoriesFailedState());
      },(data) {
        categoriesList = data;
      });
      emit(const FetchCategoriesSuccessfullyState());
    }catch(e){
      debugPrint("getAllSlidersBlocError: $e");
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
}
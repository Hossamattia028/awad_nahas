import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/products/data/models/product_small_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/domain/use_cases/comment_usecase.dart';
import 'package:awad_nahas/features/products/domain/use_cases/products_usecase.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ProductsBloc extends Bloc<ProductsEvent,ProductsState>{
  List<ProductsEntity> storedProductsList = [];
  List<ProductsEntity> productsList = [];
  ProductsEntity? currentProduct;

  List<ProductsEntity> bigOfferProducts = [];
  List<ProductsEntity> latestSellerProductsList = [];
  List<ProductsEntity> bestSellerProductsList = [];
  int currentCategoryIndex = 0;

  GetAllProductCommentsUseCase getAllProductCommentsUseCase;
  AddProductCommentUseCase addProductCommentUseCase;
  GetAllProductsUseCase getAllProductsUseCase;
  ProductsBloc({
    required this.getAllProductsUseCase,
    required this.getAllProductCommentsUseCase,
    required this.addProductCommentUseCase,
  }) : super(ProductsInitialState()) {

    on<ShowCommentsEvent>((event, emit) {
      showCommentsFun(event,emit);
    });

    on<FetchProductCommentsEvent>((event, emit) async{
      // await getProductComments(event,emit);
    });

    on<AddProductCommentEvent>((event, emit) async{
      await addProductComment(event,emit);
      // await getProductComments(event,emit);
    });

    on<UpdateCurrentProduct>((event, emit) {
      updateCurrentProduct(event,emit);
    });

    on<ChangeCurrencyEvent>((event, emit) {
    });

    on<ChangeWidgetSizeEvent>((event, emit) {
      _changeWidgetSize(event, emit);
    });

    on<FetchAllProductsEvent>((event, emit)async {
          await getAllProducts(event,emit);
    });

    // on<FilterByCategoryEvent>((FilterByCategoryEvent event, emit)async{
    //   await filterByCategory(emit,event);
    // });
    //
    // on<FilterFavProductsEvent>((FilterFavProductsEvent event, emit){
    //    filterFavProducts(event,emit);
    // });

    on<FetchAllLatestProductsEvent>((event, emit)async{
      await getAllLatestProducts(emit);
    });

    on<FetchAllBestSellerProductsEvent>((event, emit)async{
      await getAllBestSellerProducts(emit);
    });

    on<FetchOffersProductsEvent>((event, emit)async{
      await getAllOfferProducts(event,emit);
    });

  }
  static ProductsBloc get(BuildContext context) => BlocProvider.of(context);



  double widgetSize = 340;
  int index = 0;
  _changeWidgetSize(ChangeWidgetSizeEvent event,emit){
    emit(const ProductCommentsLoadingState());
    widgetSize = event.height;
    index = event.index;
    emit(const ProductsSuccessfullyState());
  }

  bool showComments = true;
  showCommentsFun(event,emit){
    emit(const ProductCommentsLoadingState());
    showComments = !showComments;
    emit(const ProductCommentsSuccessfullyState());
  }

  addProductComment(AddProductCommentEvent event,emit)async{
    if(currentProduct==null)return;
    emit(const ProductCommentsLoadingState());
    // try{
      var res = await addProductCommentUseCase(data: {
        "comment_post_ID": currentProduct!.id.toString(),
        "comment_author":Util.getUserID().toString(),
        "comment_author_email":Util.getEmail(),
        "comment_approved":"2",
        "user_id":Util.getUserID(),
        "comment_date":DateTime.now().toString(),
        "comment_content":event.txt,
        "comment_type":"2"
      });
      res.fold((l) {
        emit(const ProductCommentsFailedState());
      },(data) {
        if(data==true){
          emit(const ProductCommentsSuccessfullyState());
        }else{
          emit(const ProductCommentsFailedState());
        }
      });
    // }catch(e){
    //   debugPrint("getAllLatestProductsBlocError: $e");
    //   emit(const ProductCommentsFailedState());
    // }
  }
  //
  // getProductComments(event,emit)async{
  //   if(currentProduct==null)return;
  //   emit(const ProductCommentsLoadingState());
  //   // try{
  //     var res = await getAllProductCommentsUseCase(data: {'product_id':currentProduct!.id.toString()});
  //     res.fold((l) {
  //       emit(const ProductCommentsFailedState());
  //     },(data) {
  //       commentList = data;
  //       emit(const ProductCommentsSuccessfullyState());
  //     });
  //   // }catch(e){
  //   //   debugPrint("getAllLatestProductsBlocError: $e");
  //   //   emit(const ProductsFailedState());
  //   // }
  // }

  updateCurrentProduct(UpdateCurrentProduct event,emit){
    emit(const ProductsLoadingState());
    currentProduct = event.item;
    emit(const ProductsSuccessfullyState());
  }

  getAllLatestProducts(emit)async{
    // if(latestSellerProductsList.isNotEmpty)return;
    // emit(const ProductsFailedState());
    // try{
    var res = await getAllProductsUseCase(cat: "post_date");
    res.fold((l) {
      emit(const ProductsFailedState());
    },(data) {
      if(data.isNotEmpty){
        latestSellerProductsList = data;
        emit(const ProductsSuccessfullyState());
      }
    });
    // }catch(e){
    //   debugPrint("getAllLatestProductsBlocError: $e");
    //   emit(const ProductsFailedState());
    // }
  }

  getAllProducts(event,emit)async{
    // if(latestSellerProductsList.isNotEmpty)return;
    // emit(const ProductsFailedState());
    // try{
      var res = await getAllProductsUseCase(cat: "name");
      res.fold((l) {
        emit(const ProductsFailedState());
      },(data) {
        if(data.isNotEmpty){
          productsList = data;
          emit(const ProductsSuccessfullyState());
        }
      });
    // }catch(e){
    //   debugPrint("getAllLatestProductsBlocError: $e");
    //   emit(const ProductsFailedState());
    // }
  }

  getAllBestSellerProducts(emit)async{
    // if(bestSellerProductsList.isNotEmpty)return;
    // emit(const ProductsFailedState());
    // try{
      var res = await getAllProductsUseCase(cat: "top");
      res.fold((l) {
        emit(const ProductsFailedState());
      },(data) {
        if(data.isNotEmpty){
          bestSellerProductsList = data;
          emit(const ProductsSuccessfullyState());
        }
      });
    // }catch(e){
    //   debugPrint("getAllBestSellerProductsBlocError: $e");
    //   emit(const ProductsFailedState());
    // }
  }

  getAllOfferProducts(FetchOffersProductsEvent event,emit)async{
    // if(bigOfferProducts.isNotEmpty)return;
    // emit(const ProductsFailedState());
    // try{
      var res = await getAllProductsUseCase(cat: "offers");
      res.fold((l) {
        emit(const ProductsFailedState());
      },(data) {
        if(data.isNotEmpty){
          bigOfferProducts = data;
          emit(const ProductsSuccessfullyState());
        }
      });
    // }catch(e){
    //   debugPrint("getAllBestSellerProductsBlocError: $e");
    //   emit(const ProductsFailedState());
    // }
  }



  List<ProductsEntity> filterByCategoryID(int catId,int subCatID){
    List<ProductsEntity> list = [];
    for(var i in productsList){
      for(var cat in i.categoryList){
        if(cat.id == catId && subCatID==-1){
          list.add(i);
        }else if(cat.id == catId || cat.id == subCatID){
          list.add(i);
        }
      }
    }
    return list;
    // return productsList.where((element) => element.catID.toString().trim()==catId.toString().trim()).toList();
  }

  List<ProductsEntity> relatedProducts(List<CategoriesEntity> catList){
    List<ProductsEntity> list = [];
    for(var i in catList){
      for(var p in productsList){
          if(p.categoryList.contains(i)){
             list.add(p);
          }
      }
      // list.addAll(productsList.where((element) => element.categoryList.contains(i)).toList());
    }
    return list;
  }

  List<ProductsEntity> brandProducts(int brandID){
    return productsList.where((element) => element.brandID == brandID).toList();
  }

  List<ProductsEntity> filterByCurrentLang(List<ProductsEntity> list){
    if(Util.getLang()=="ar"){
      return list.where((element) => element.isArabic==true).toList();
    }else{
      return list.where((element) => element.isArabic==false).toList();
    }
  }


}
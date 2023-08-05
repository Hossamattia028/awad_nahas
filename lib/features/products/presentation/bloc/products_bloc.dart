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
  List<ProductsEntity> productsList = [
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
          CategoriesEntity(title: "Cooker Hobs", id: 2, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
          CategoriesEntity(title: "Cooker Hobs", id: 3, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
        ], commentCount: 20),
    const ProductsEntity(title: "Smeg 50’s Style Retro Aesthetic", catTitle: "Small Appliances", desc: "Small Appliances", id:2,
        imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/smeg.png?alt=media&token=9c98c424-0525-49dc-beeb-6900acfedf35",
        price: 200, discount: 20, discountRate: 20, stockStatus: true, quantity: 2, categoryList: [
          CategoriesEntity(title: "Cooker Hobs", id: 2, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
          CategoriesEntity(title: "Cooker Hobs", id: 3, imgPath: "https://firebasestorage.googleapis.com/v0/b/tabib-14438.appspot.com/o/Group%202178.png?alt=media&token=ca40a23d-3788-49dc-b2d6-e1dc164d9ee4"),
        ], commentCount: 20),
  ];
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
      await getProductComments(event,emit);
    });

    on<AddProductCommentEvent>((event, emit) async{
      await addProductComment(event,emit);
      await getProductComments(event,emit);
    });

    on<UpdateCurrentProduct>((event, emit) {
      updateCurrentProduct(event,emit);
    });

    on<ChangeCurrencyEvent>((event, emit) {
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




  bool showComments = true;
  showCommentsFun(event,emit){
    emit(const ProductCommentsLoadingState());
    showComments = !showComments;
    emit(const ProductCommentsSuccessfullyState());
  }

  addProductComment(AddProductCommentEvent event,emit)async{
    if(currentProduct==null)return;
    emit(const ProductCommentsLoadingState());
    try{
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
    }catch(e){
      debugPrint("getAllLatestProductsBlocError: $e");
      emit(const ProductCommentsFailedState());
    }
  }

  List<ProductComments> commentList = [];
  getProductComments(event,emit)async{
    if(currentProduct==null)return;
    emit(const ProductCommentsLoadingState());
    try{
      var res = await getAllProductCommentsUseCase(data: {'product_id':currentProduct!.id.toString()});
      res.fold((l) {
        emit(const ProductCommentsFailedState());
      },(data) {
        commentList = data;
        emit(const ProductCommentsSuccessfullyState());
      });
    }catch(e){
      debugPrint("getAllLatestProductsBlocError: $e");
      emit(const ProductsFailedState());
    }
  }

  updateCurrentProduct(UpdateCurrentProduct event,emit){
    emit(const ProductsLoadingState());
    currentProduct = event.item;
    commentList.clear();
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



  List<ProductsEntity> filterByCategoryID(int catId){
    List<ProductsEntity> list = [];
    for(var i in productsList){
      for(var x in i. categoryList){
        if(x.id==catId){
          list.add(i);
        }
      }
    }
    return list;
  }


}
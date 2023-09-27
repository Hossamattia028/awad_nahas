import 'package:awad_nahas/core/strings/enum/filter_enum.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
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

    on<UpdateAllProductsEvent>((event, emit)async {
        updateProducts(event,emit);
    });

    /// search
    on<EnableSearchEvent>((event, emit)async{
      modifySearchAvailability(event,emit);
    });

    on<UpdateSearchProductList>((event, emit){
      updateProductSearchList(event,emit);
    });
    /// filter section
    on<ChangeSortEvent>((event, emit){
      changeSort(event,emit);
    });

    on<FilterProductEvent>((event, emit){
      filterProducts(event,emit);
    });

    on<EnableBrandFilterEvent>((event, emit){
      enableBrandFilter(event,emit);
    });

    on<EnableWeightFilterEvent>((event, emit){
      enableWightFilter(event,emit);
    });

    on<ShowFullContentEvent>((event, emit){
      showFullContentFn(event, emit);
    });


  }
  static ProductsBloc get(BuildContext context) => BlocProvider.of(context);


  /// product details states
  bool showFullContent = false;
  showFullContentFn(ShowFullContentEvent event,emit){
    emit(const ProductsLoadingState());
    showFullContent = event.val!=null ? event.val! : !showFullContent;
    emit(const ProductsSuccessfullyState());
  }

  double widgetSize = 250;
  int index = 0;
  _changeWidgetSize(ChangeWidgetSizeEvent event,emit){
    emit(const ProductsLoadingState());
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


  updateCurrentProduct(UpdateCurrentProduct event,emit){
    emit(const ProductsLoadingState());
    currentProduct = event.item;
    emit(const ProductsSuccessfullyState());
  }


  List<double> weightList = [];
  _calcWeight(List<ProductsEntity> productsList){
    for(var i in productsList){
      if(i.attributes!=null  && !weightList.contains(i.attributes?.weight))weightList.add(i.attributes!.weight);
    }
  }

  getAllProducts(event,emit)async{
    emit(const ProductsFailedState());
    try{
      var res = await getAllProductsUseCase(cat: "name");
      res.fold((l) {
        emit(const ProductsFailedState());
      },(data) {
        if(data.isNotEmpty){
          storedProductsList = data;
          productsList = filterByCurrentLang(storedProductsList);
          _calcWeight(productsList);
          emit(const ProductsSuccessfullyState());
        }
      });
    }catch(e){
      debugPrint("getAllLatestProductsBlocError: $e");
      emit(const ProductsFailedState());
    }
  }

  updateProducts(event,emit){
    emit(const ProductsLoadingState());
    productsList = filterByCurrentLang(storedProductsList);
    emit(const ProductsSuccessfullyState());
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
  }

  List<ProductsEntity> relatedProducts(List<CategoriesEntity> catList){
    List<ProductsEntity> list = [];
    for(var i in catList){
      for(var p in productsList){
          if(p.categoryList.contains(i)){
             list.add(p);
          }
      }
    }
    return list;
  }

  List<ProductsEntity> brandProducts(int brandID,{List<ProductsEntity>? list}){
    if(list!=null){
      return list.where((element) => element.brandID == brandID).toList();
    }
    return productsList.where((element) => element.brandID == brandID).toList();
  }

  List<ProductsEntity> filterByCurrentLang(List<ProductsEntity> list){
    if(Util.getLang()=="ar"){
      return list.where((element) => element.isArabic==true).toList();
    }else{
      return list.where((element) => element.isArabic==false).toList();
    }
  }

  /// search section
  List<ProductsEntity> productSearchList = [];
  List<CategoriesEntity> categorySearchList = [];

  bool enableSearch = false;
  modifySearchAvailability(EnableSearchEvent event,emit){
    emit(const FilterLoadingState());
    if(event.enable!=null){
      enableSearch = event.enable!;
    }else{
      enableSearch = !enableSearch;
    }
    if(event.productList!=null)productSearchList = event.productList!;
    emit(const FilterSuccessfullyState());
  }

  searchProductsAndCategories(SearchModel searchModel)async{
    try{
      // productSearchList = productsList;
      if(searchModel.word.toString().trim()==""){
        enableSearch = false;
        categorySearchList.clear();
        productSearchList.clear();
        return;
      }
      if(searchModel.categoryList.isNotEmpty)categorySearchList = searchCategories(searchModel.word,searchModel.categoryList);
      if(productsList.isNotEmpty)await searchProducts(searchModel.word,productsList);
      enableSearch = true;
    }catch(e){
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
  Future searchProducts(String word,List<ProductsEntity> list)async{
    List<ProductsEntity> thisList  = [];
    try{
      var firstList = list.getRange(0, list.length~/2).toList();
      thisList.addAll(firstList.where((element) => element.title.toString().toLowerCase().startsWith(word) || element.sku.toString().toLowerCase().startsWith(word)).toList());
      productSearchList = thisList;
      enableSearch = true;
      await Future.delayed(const Duration(seconds: 2),(){
        var secondList =  list.getRange(list.length~/2, list.length).toList();
        thisList.addAll(secondList.where((element) => element.title.toString().toLowerCase().startsWith(word) || element.sku.toString().toLowerCase().startsWith(word)).toList());
        productSearchList.addAll(thisList.toList());
        productSearchList = [...{...productSearchList}];
      });
    }catch(e){
      debugPrint("searchProducts: $e");
      return [];
    }
  }

  updateProductSearchList(UpdateSearchProductList event,emit){
    emit(const FilterLoadingState());
    if(event.productList!=null)productSearchList = event.productList!;
    if(event.sortEnum!=null)productSearchList = sortProducts(event.sortEnum!);
    emit(const FilterSuccessfullyState());
  }

  /// filter & sort products section
  SortEnum currentSort = SortEnum.POPULAR;
  changeSort(ChangeSortEvent event,emit){
    emit(const FilterLoadingState());
    currentSort = event.sortEnum;
    sortProducts(currentSort);
    emit(const FilterSuccessfullyState());
  }

  sortProducts(SortEnum sortType){
    if(sortType == SortEnum.NEW){
      productSearchList.sort((a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
    }else if(sortType == SortEnum.PRICE_HIGH_TO_LOW){
      productSearchList.sort((a, b) => b.price.compareTo(a.price));
    }else if(sortType == SortEnum.PRICE_LOW_TO_HIGH){
      productSearchList.sort((a, b) => a.price.compareTo(b.price));
    }else if(sortType == SortEnum.AVERAGE_RATE){
      productSearchList.sort((a, b) => double.parse(b.averageRate.toString()).compareTo(double.parse(a.averageRate.toString())));
    }else{
      productSearchList = storedProductsList;
    }
  }

  /// filter
  FilterModel? filterModel;
  filterProducts(FilterProductEvent event,emit){
    emit(const FilterLoadingState());
    try{
      productSearchList = filterByCurrentLang(storedProductsList);
      if(event.filterModel==null){
        filterModel  = null;
        enableSearch = false;
        textStartEditingController.text = "";
        textEndEditingController.text = "";
        emit(const FilterSuccessfullyState());
        return;
      }
      filterModel = event.filterModel;
      if(event.filterModel!.searchModel!=null)searchProductsAndCategories(event.filterModel!.searchModel!);
      if(event.filterModel!.filterPrice!=null && (event.filterModel!.filterPrice?.end!=0.0 || event.filterModel!.filterPrice?.start!=0.0))productSearchList = filterPrice(event.filterModel!.filterPrice!);
      if(event.filterModel!.isAvailable!=null && event.filterModel!.isAvailable==true)productSearchList = filterStock(productSearchList);
      if(event.filterModel!.isDiscount!=null && event.filterModel!.isDiscount == true)productSearchList = filterIfHasDiscount(productSearchList);
      if(event.filterModel!.brandID!=null && showBrandFilter == true)productSearchList = filterByBrandID(productSearchList,event.filterModel!.brandID!);
      if(event.filterModel!.weight!=null && showWeightFilter == true)productSearchList = filterByWeight(productSearchList,event.filterModel!.weight!);
      emit(const FilterSuccessfullyState());
    }catch(e){
      debugPrint("filterProducts: $e");
      emit(const SearchFailedState());
    }
  }

  final TextEditingController textStartEditingController = TextEditingController();
  final TextEditingController textEndEditingController = TextEditingController();
  filterPrice(FilterPrice filterPrice){
    productSearchList = productSearchList.where((element) => element.price<=filterPrice.end && element.price>=filterPrice.start).toList();
    return productSearchList;
  }


  /// filter by stock if true is instock
  filterStock(List<ProductsEntity> products){
    products = products.where((element) => element.stockStatus==true).toList();
    return products;
  }

  /// filter if product has discount or not
  filterIfHasDiscount(List<ProductsEntity> products){
    products = products.where((element) => element.discount !=0 && element.discount!=element.price).toList();
    return products;
  }

  bool showBrandFilter = false;
  enableBrandFilter(event,emit){
    emit(const FilterLoadingState());
    showBrandFilter = !showBrandFilter;
    emit(const FilterSuccessfullyState());
  }

  /// filter by brand id
  filterByBrandID(List<ProductsEntity> products,int brandID){
    products = products.where((element) => element.brandID == brandID).toList();
    return products;
  }


  bool showWeightFilter = false;
  enableWightFilter(event,emit){
    emit(const FilterLoadingState());
    showWeightFilter = !showWeightFilter;
    emit(const FilterSuccessfullyState());
  }
  /// filter by weight
  filterByWeight(List<ProductsEntity> products,double weight){
    products = products.where((element) => element.attributes?.weight == weight).toList();
    return products;
  }

}

// List<ProductsEntity> sortProducts(SortEnum sortType,List<ProductsEntity> list){
//   if(sortType == SortEnum.NEW){
//     list.sort((a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
//   }else if(sortType == SortEnum.PRICE_HIGH_TO_LOW){
//     list.sort((a, b) => b.price.compareTo(a.price));
//   }else if(sortType == SortEnum.PRICE_LOW_TO_HIGH){
//     list.sort((a, b) => a.price.compareTo(b.price));
//   }else if(sortType == SortEnum.AVERAGE_RATE){
//     list.sort((a, b) => double.parse(b.averageRate.toString()).compareTo(double.parse(a.averageRate.toString())));
//   }else{
//     list = list;
//   }
//   return list;
// }

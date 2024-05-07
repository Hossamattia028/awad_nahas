import 'package:awad_nahas/core/strings/enum/filter_enum.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/products/data/models/product_comments.dart';
import 'package:awad_nahas/features/products/data/models/size_model.dart';
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

    on<UpdateProductsStateEvent>((event, emit)async {
        updateProductsState(event,emit);
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

    on<FilterProductEvent>((event, emit)async{
      await filterProducts(event,emit);
    });

    on<EnableBrandFilterEvent>((event, emit){
      enableBrandFilter(event,emit);
    });

    on<EnableCategoryFilterEvent>((event, emit){
      enableCategoryFilter(event,emit);
    });

    on<EnableColorFilterEvent>((event, emit){
      enableColorFilter(event,emit);
    });

    on<EnableSizeFilterEvent>((event, emit){
      enableSizeFilter(event,emit);
    });

    on<EnableWeightFilterEvent>((event, emit){
      enableWightFilter(event,emit);
    });

    on<ShowFullContentEvent>((event, emit){
      showFullContentFn(event, emit);
    });

    on<UpdateProductCommentEvent>((event, emit){
      updateRatingValue(event, emit);
    });

    on<UpdateCurrentCatAndSubCat>((event, emit){
      setCurrentCategory(event, emit);
    });

    // on<UpdateCurrentCatAndSubCatFilterEvent>((event, emit){
      // setCurrentFilterCategory(event, emit);
    // });

    on<UpdateFilterAttributesDataEvent>((event, emit){
      updateFilterAttributes(event, emit);
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

  double ratingVal = 2.5;
  updateRatingValue(UpdateProductCommentEvent event,emit){
    emit(const UpdateRatingLoadingState());
    ratingVal = event.value;
    emit(const UpdateRatingLoadingState());
  }
  addProductComment(AddProductCommentEvent event,emit)async{
    emit(const ProductCommentsLoadingState());
    try{
      var res = await addProductCommentUseCase(data: {
        "product_id": event.productId,
        "user_name": Util.getFullName(),
        "user_email": Util.getEmail(),
        "user_id": Util.getUserID(),
        "comment": event.txt,
        "rating": double.parse(ratingVal.toString()).toInt(),
      });
      res.fold((l) {
        emit(const ProductCommentsFailedState());
      },(data) {
        if(data==true){
          addNewCommentToProduct(event);
          emit(const ProductCommentsSuccessfullyState());
        }else{
          emit(const ProductCommentsFailedState());
        }
      });
    }catch(e){
      debugPrint("addProductComment: $e");
      emit(const ProductCommentsFailedState());
    }
  }

  addNewCommentToProduct(AddProductCommentEvent event){
    int index = storedProductsList.indexWhere((element) => element.id == event.productId);
    if(index!=-1){
      var item = storedProductsList[index];
      var com = ProductComments(
          productID: item.id,
          rating: ratingVal,
          commentContent: event.txt,
          commentType: 'review',
          userID: int.tryParse(Util.getUserID())!=null?int.parse(Util.getUserID()):0, date: DateTime.now().toString(), userName: Util.getFullName());
      List<ProductComments> list = item.reviewsList ?? [];
      list.add(com);
      item = ProductsEntity(
          title: item.title,
          catTitle: item.catTitle,
          desc: item.desc, id: item.id, sku: item.sku,
          imgPath: item.imgPath,
          price: item.price,
          priceWithoutTax: item.priceWithoutTax,
          discount: item.discount,
          discountRate: item.discountRate,
          stockStatus: item.stockStatus,
          quantity: item.quantity,
          categoryList: item.categoryList,
          catID: item.catID,
          commentCount: item.commentCount,
          reviewsList: list
      );
    }
  }

  updateCurrentProduct(UpdateCurrentProduct event,emit){
    emit(const ProductsLoadingState());
    currentProduct = event.item;
    emit(const ProductsSuccessfullyState());
  }


  List<double> weightList = [];
  // _storeWeight(List<ProductsEntity> productsList){
  //   if(weightList.isNotEmpty)return;
  //   for(var i in productsList){
  //     if(i.attributes!=null  && !weightList.contains(i.attributes?.weight))weightList.add(i.attributes!.weight);
  //   }
  // }

  List<SizeModel> sizeList = [];
  // _storeSize(){
  //   if(sizeList.isNotEmpty)return;
  //   for(var i in productsList){
  //     var sizeModel = SizeModel(height: i.attributes!.height, width: i.attributes!.width);
  //     if(i.attributes!=null  && !sizeList.contains(sizeModel))sizeList.add(sizeModel);
  //   }
  // }

  List<String> colorList = [];
  _storeColor(){
    if(colorList.isNotEmpty)return;
    for(var i in productsList){
      if(i.attributes!=null  && !colorList.contains(i.attributes?.color))colorList.add(i.attributes!.color);
    }
  }

  updateFilterAttributes(event,emit){
    /// set current category with null
    currentCat = null;
    currentSubCat = null;
    _storeColor();
    // _storeSize();
  }


  int allProductsCount = 300;
  getAllProducts(FetchAllProductsEvent event,emit)async{
    if(storedProductsList.length>300 && event.urgentUpdate==false)return;
    emit(const ProductsLoadingState());
    try{
      var res = await getAllProductsUseCase(parameter: event.page);
      res.fold((l) {
        emit(const ProductsFailedState());
      },(data) {
        if(data.products.isNotEmpty){
          storedProductsList = data.products;
          productsList = filterByCurrentLang(storedProductsList);
          emit(const ProductsSuccessfullyState());
        }
      });
    }catch(e){
      debugPrint("getAllProducts: $e");
      emit(const ProductsFailedState());
    }
  }

  bool updated = false;
  updateProductsState(event,emit){
    if(updated == true || storedProductsList.length<300)return;
    emit(const ProductsLoadingState());
    productsList = productsList;
    updated = true;
    emit(const ProductsSuccessfullyState());
  }

  updateProducts(event,emit){
    emit(const ProductsLoadingState());
    productsList = filterByCurrentLang(storedProductsList);
    emit(const ProductsSuccessfullyState());
  }


  int? currentCat;
  int? currentSubCat;
  setCurrentCategory(UpdateCurrentCatAndSubCat event,emit){
    emit(const FilterLoadingState());
    currentCat=event.catID;
    currentSubCat=event.subCatID;
    emit(const FilterSuccessfullyState());
  }

  List<ProductsEntity> filterByCategoryID(int catId,int subCatID,{List<ProductsEntity>? productList}){
    List<ProductsEntity> usedList = [];
    if(productList!=null){
      usedList = productList;
    }else{
      usedList = productsList;
    }
    List<ProductsEntity> list = [];
    for(var i in usedList){
      for(var cat in i.categoryList){
        if(cat.id == catId && subCatID==-1){
          list.add(i);
        }else if(subCatID != -1){
          if(cat.id == subCatID){
            list.add(i);
          }
        }
      }
    }
    return list;
  }

  List<ProductsEntity> relatedProducts(List<CategoriesEntity> catList){
    List<ProductsEntity> list = [];
    for(var i in catList){
      for(var p in productsList){
        if(p.categoryList.where((element) => element.id==i.id).toList().isNotEmpty){
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



  /// search & filter section
  /// main function for search & filter
  FilterModel? filterModel;
  filterProducts(FilterProductEvent event,emit)async{
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
      if(event.filterModel!.searchModel!=null && event.filterModel?.searchModel?.word!="")await searchProductsAndCategories(event.filterModel!.searchModel!,emit);
      if(event.filterModel!.filterPrice!=null && (event.filterModel!.filterPrice?.end!=0.0 || event.filterModel!.filterPrice?.start!=0.0))productSearchList = filterPrice(event.filterModel!.filterPrice!);
      if(event.filterModel!.isAvailable!=null && event.filterModel!.isAvailable==true)productSearchList = filterStock(productSearchList);
      if(event.filterModel!.isDiscount!=null && event.filterModel!.isDiscount == true)productSearchList = filterIfHasDiscount(productSearchList);
      if(event.filterModel!.brandID!=null && showBrandFilter == true && event.filterModel!.brandID!.isNotEmpty)productSearchList = filterByBrandID(productSearchList,event.filterModel!.brandID!);
      if(event.filterModel!.color!=null && showColorFilter == true && event.filterModel!.color!.isNotEmpty)productSearchList = filterByColor(productSearchList,event.filterModel!.color!);
      if(event.filterModel!.catID!=null && showCategoryFilter == true && event.filterModel!.catID!.isNotEmpty) productSearchList = filterByCategoryList(productSearchList, event.filterModel!.catID!);
      // if(event.filterModel!.weight!=null && showWeightFilter == true)productSearchList = filterByWeight(productSearchList,event.filterModel!.weight!);
      if(currentCat!=null)productSearchList = filterByCategoryID(currentCat!, currentSubCat??-1,productList: productSearchList);
      emit(const FilterSuccessfullyState());
    }catch(e){
      debugPrint("filterProducts: $e");
      emit(const SearchFailedState());
    }
  }

  bool showCategoryFilter = false;
  enableCategoryFilter(event,emit){
    emit(const FilterLoadingState());
    showCategoryFilter = !showCategoryFilter;
    emit(const FilterSuccessfullyState());
  }

  final TextEditingController textStartEditingController = TextEditingController();
  final TextEditingController textEndEditingController = TextEditingController();
  filterPrice(FilterPrice filterPrice){
    debugPrint("filterPrice");
    productSearchList = productSearchList.where((element) => element.discount<=filterPrice.end && element.discount>=filterPrice.start).toList();
    return productSearchList;
  }


  /// filter by stock if true is in_stock
  filterStock(List<ProductsEntity> products){
    debugPrint("filterStock");
    products = products.where((element) => element.stockStatus==true).toList();
    return products;
  }

  /// filter if product has discount or not
  filterIfHasDiscount(List<ProductsEntity> products){
    debugPrint("filterIfHasDiscount");
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
  filterByBrandID(List<ProductsEntity> products,List<int> brandIDList){
    debugPrint("filterByBrandID");
    return products.where((element) => brandIDList.contains(element.brandID)).toList();
  }

  /// filter by brand id
  filterByCategoryList(List<ProductsEntity> products,List<int> catList){
    debugPrint("filterByCategoryList");
    List<ProductsEntity> list = [];
    for(var i in catList){
      list.addAll(filterByCategoryID(i, -1, productList: products));
    }
    return list;
  }

  bool showWeightFilter = false;
  enableWightFilter(event,emit){
    emit(const FilterLoadingState());
    showWeightFilter = !showWeightFilter;
    emit(const FilterSuccessfullyState());
  }
  /// filter by weight
  filterByWeight(List<ProductsEntity> products,double weight){
    debugPrint("filterByWeight");
    products = products.where((element) => element.attributes?.weight == weight).toList();
    return products;
  }


  bool showColorFilter = false;
  enableColorFilter(event,emit){
    emit(const FilterLoadingState());
    showColorFilter = !showColorFilter;
    emit(const FilterSuccessfullyState());
  }
  /// filter by weight
  filterByColor(List<ProductsEntity> products,List<String> colorList){
    debugPrint("filterByColor");
    products = products.where((element) => colorList.contains(element.attributes?.color.toString().trim())).toList();
    return products;
  }

  bool showSizeFilter = false;
  enableSizeFilter(event,emit){
    emit(const FilterLoadingState());
    showSizeFilter = !showSizeFilter;
    emit(const FilterSuccessfullyState());
  }
  /// filter by weight
  filterBySize(List<ProductsEntity> products,double height){
    debugPrint("filterBySize");
    products = products.where((element) => element.attributes?.height == height).toList();
    return products;
  }

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

  searchProductsAndCategories(SearchModel searchModel,emit)async{
    try{
      // productSearchList = productsList;
      if(searchModel.word.toString().trim()==""){
        enableSearch = false;
        categorySearchList.clear();
        productSearchList.clear();
        return;
      }
      if(searchModel.categoryList.isNotEmpty)categorySearchList = searchCategories(searchModel.word,searchModel.categoryList);
      int index = searchModel.brandList.indexWhere((element) => element.title.trim() == searchModel.word.trim());
      if(productSearchList.isNotEmpty)await searchProducts(searchModel.word,productSearchList,index!=-1?searchModel.brandList[index].id:-1,emit);
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
  Future searchProducts(String word,List<ProductsEntity> list,int brandID,emit)async{
    debugPrint("searchProducts");
    List<ProductsEntity> thisList  = [];
    try{
      var firstList = list.getRange(0, list.length~/2).toList();
      thisList.addAll(firstList.where((element) => element.title.toString().toLowerCase().startsWith(word) || element.sku.toString().toLowerCase().startsWith(word) || element.brandID == brandID).toList());
      productSearchList = thisList;
      enableSearch = true;
      await Future.delayed(const Duration(seconds: 2),(){
        var secondList =  list.getRange(list.length~/2, list.length).toList();
        thisList.addAll(secondList.where((element) => element.title.toString().toLowerCase().startsWith(word) || element.sku.toString().toLowerCase().startsWith(word) || element.brandID == brandID).toList());
        productSearchList.addAll(thisList.toList());
        productSearchList = [...{...productSearchList}];
      });
      emit(const FilterSuccessfullyState());
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
      productsList.sort((a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
    }else if(sortType == SortEnum.PRICE_HIGH_TO_LOW){
      productSearchList.sort((a, b) => b.price.compareTo(a.price));
      productsList.sort((a, b) => b.price.compareTo(a.price));
    }else if(sortType == SortEnum.PRICE_LOW_TO_HIGH){
      productSearchList.sort((a, b) => a.price.compareTo(b.price));
      productsList.sort((a, b) => a.price.compareTo(b.price));
    }else if(sortType == SortEnum.AVERAGE_RATE){
      productSearchList.sort((a, b) => double.parse(b.averageRate.toString()).compareTo(double.parse(a.averageRate.toString())));
      productsList.sort((a, b) => double.parse(b.averageRate.toString()).compareTo(double.parse(a.averageRate.toString())));
    }else{
      productSearchList = storedProductsList;
    }
  }

}
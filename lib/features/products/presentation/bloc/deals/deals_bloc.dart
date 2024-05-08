import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/products/domain/entities/deals_entity.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/domain/use_cases/deals/deals.dart';
import 'package:awad_nahas/features/products/presentation/bloc/deals/deals_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/deals/deals_state.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealsBloc extends Bloc<DealsEvent,DealsState>{
  final GetAllProductsDealsUseCase getAllProductsDealsUseCase;


  static DealsBloc get(BuildContext context) => BlocProvider.of(context);
  DealsBloc({
    required this.getAllProductsDealsUseCase,
  }):super(DealsInitialState()){


    on<FetchAllDealsEvent>(((event, emit) async{
      await getAllProductsDeals(event, emit);
    }));


  }
 
 convertToFreeProduct(ProductsEntity item,String parentProduct){
  return ProductsEntity(title: item.title,
            catTitle: "", sku: item.sku,
            desc: "", id: item.id,discountRate: 0,
            imgPath: item.imgPath,
            discountParentProduct: [...item.discountParentProduct??[],parentProduct],
            price:  0 , priceWithoutTax: 0 ,
            discount:0 , stockStatus: true,
            quantity: item.quantity,categoryList: const [],commentCount: 0,catID: item.catID);
 }

 ///deals section
  List<DealsEntity> productsDeals = [];
  getAllProductsDeals(event,emit)async{
    emit(const DealsLoadingState());
    try{
      var res = await getAllProductsDealsUseCase();
      res.fold((l) {
        emit(const DealsFailedState());
      },(data) {
         if(data.isNotEmpty)productsDeals = data;
         emit(const DealsSuccessfullyState());
      });
    }catch(e){
      debugPrint("getAllProductsDealsBloc: $e");
      emit(const DealsFailedState());
    }
  }


  /// [BUY_X_GET_Y]
  List<ProductsEntity> getProductsHasBuyXGetYOffer(BuildContext context){
    List<ProductsEntity> list = [];
    var productsBloc = ProductsBloc.get(context);
    var dealsBloc = DealsBloc.get(context);
    var dealsList =  dealsBloc.productsDeals.where((i) => i.buyXGetYFree!=null && i.buyXGetYFree!.isNotEmpty && i.checkLangInsideDeal()).toList();
    for(var i in dealsList){
        if(i.mainProducts!=null || i.mainProducts!.isNotEmpty){
          for(var mainProduct in i.mainProducts!){
            int mainProductIndex = productsBloc.productsList.indexWhere((element) => element.id.toString() == mainProduct);
            if(mainProductIndex!=-1)list.add(productsBloc.productsList[mainProductIndex]);
          }
      }
    }
    return list;
  }
  
  checkCaseBuyXGetYDeal({required ProductsEntity product,required remove,required BuildContext context,int? count}){
    var cartBloc = CartBloc.get(context);
    var productsBloc = ProductsBloc.get(context);
    var dealsBloc = DealsBloc.get(context);
    var dealsList =  dealsBloc.productsDeals.where((i) => i.buyXGetYFree!=null && i.buyXGetYFree!.isNotEmpty && i.checkLangInsideDeal()).toList();
    for(var i in dealsList){
        if(i.mainProducts==null || i.mainProducts!.isEmpty)return;
        int productIndex = i.mainProducts!.indexWhere((element) => element.toString() == product.id.toString());
        if(productIndex!=-1){
          for(var y in i.buyXGetYFree!){
            int freeProductindex = productsBloc.productsList.indexWhere((element) => y.toString() == element.id.toString());
            if(freeProductindex == -1)return;
            var item = productsBloc.productsList[freeProductindex];
            cartBloc.checkItemAndModifyInsideCart(product: dealsBloc.convertToFreeProduct(item, product.id.toString()),count: count,remove: remove,isFree: true);
          }
      }
    }
  }



  /// [BUY_X_Y_GET_Z]
  List<BuyXYGetZ> getProductsHasBuyXYGetZOffer(BuildContext context){
    List<BuyXYGetZ> mainList = [];
    var productsBloc = ProductsBloc.get(context);
    var dealsBloc = DealsBloc.get(context);
    var dealsList =  dealsBloc.productsDeals.where((i) => i.buyXYGetZFree!=null && i.buyXYGetZFree!.isNotEmpty && i.checkLangInsideDeal()).toList();
    for(var i in dealsList){
        List<ProductsEntity> list  = [];
        if(i.mainProducts!=null || i.mainProducts!.isNotEmpty){
          for(var mainProduct in i.mainProducts!){
            int mainProductIndex = productsBloc.productsList.indexWhere((element) => element.id.toString() == mainProduct);
            if(mainProductIndex!=-1)list.add(productsBloc.productsList[mainProductIndex]);
          }
          mainList.add(BuyXYGetZ(banner: i.banner, list: list));
      }
    }
    return mainList;
  }

  checkCaseBuyXYGetZDeal({required ProductsEntity product,required remove,required BuildContext context,int? count}){
    var cartBloc = CartBloc.get(context);
    var productsBloc = ProductsBloc.get(context);
    var dealsBloc = DealsBloc.get(context);
    var dealsList =  dealsBloc.productsDeals.where((i) => i.buyXYGetZFree!=null && i.buyXYGetZFree!.isNotEmpty && i.checkLangInsideDeal());
    for(var i in dealsList){
        if(i.mainProducts==null || i.mainProducts!.isEmpty)return;
        int productIndex = i.mainProducts!.indexWhere((element) => element.toString() == product.id.toString());
        if(productIndex!=-1 && checkXAndYInCart(i.mainProducts!,cartBloc) == true){
          for(var y in i.buyXYGetZFree!){
            int freeProductindex = productsBloc.productsList.indexWhere((element) => y.toString() == element.id.toString());
            if(freeProductindex == -1)return;
            var item = productsBloc.productsList[freeProductindex];
            cartBloc.checkItemAndModifyInsideCart(product: dealsBloc.convertToFreeProduct(item, product.id.toString()),count: count,remove: remove,isFree: true);
          }
      }
    }
  }

  bool checkXAndYInCart(List<String> productsIDS,CartBloc cartBloc){
    for(var i in productsIDS){
      if(cartBloc.cartList.indexWhere((element) => element.id.toString() == i)==-1)return false;
    }
    return true;
  }


}
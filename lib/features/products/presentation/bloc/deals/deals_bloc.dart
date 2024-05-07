import 'package:awad_nahas/core/utils/small_fun.dart';
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
      debugPrint("getAllProductsDeals: $e");
      emit(const DealsFailedState());
    }
  }



  List<ProductsEntity> getProductsHasBuyXGetYOffer(BuildContext context){
    List<ProductsEntity> list = [];
    var productsBloc = ProductsBloc.get(context);
    var dealsBloc = DealsBloc.get(context);
    var dealsList =  dealsBloc.productsDeals;
    for(var i in dealsList){
      if(i.buyXGetYFree!=null && i.buyXGetYFree!.isNotEmpty && ((Util.getLang()=="ar"&&i.isArabic==true) || (Util.getLang()=="en_US"&&i.isArabic==false))){
        if(i.mainProducts!=null || i.mainProducts!.isNotEmpty){
          for(var mainProduct in i.mainProducts!){
            int mainProductIndex = productsBloc.productsList.indexWhere((element) => element.id.toString() == mainProduct);
            if(mainProductIndex!=-1)list.add(productsBloc.productsList[mainProductIndex]);
          }
        }
      }
    }
    return list;
  }

}
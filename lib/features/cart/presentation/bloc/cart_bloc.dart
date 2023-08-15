// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/generat_cart_post_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/cart/domain/use_cases/cart_usecase.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  AddCartItemUseCase addCartItemUseCase;
  GetAllCartListUseCase getAllCartListUseCase;
  RemoveCartItemUseCase removeCartItemUseCase;
  ApplyCouponUseCase applyCouponUseCase;
  int currentCategoryIndex = 0;
  CartBloc({
    required this.getAllCartListUseCase,
    required this.addCartItemUseCase,
    required this.removeCartItemUseCase,
    required this.applyCouponUseCase,
  }) : super(CartInitialState()) {
    on<ImplementCouponDiscountEvent>((event, emit)async {
      await getDiscountCoupon(event,emit);
    });
    on<UpdateCouponContainerEvent>((event, emit) {
      // updateCouponContainer(event,emit);
    });
    on<UpdateShippingCostEvent>((event, emit) async{
      // await updateShippingCost(event,emit);
    });
    on<FetchAllCartEvent>((event, emit) async{
      await getAllCart(emit);
    });
    on<AddToCartEvent>((event, emit) async{
      await addToCartList(event,emit);
      await getAllCart(emit);
    });
    on<ModifyCartProductEvent>((event, emit) async{
      await modifyCartProduct(event,emit);
    });

    on<UpdateCountEvent>((event, emit) {
      if(event.value == 0)return;
      emit(CartLoadingState());
      cartCount = event.value;
      emit(CartSuccessfullyState());
    });
  }
  static CartBloc get(BuildContext context) => BlocProvider.of(context);

  int cartCount = 1;
  List<ProductsEntity> cartList = [];

  getAllCart(emit)async{
    if(!Util.checkUser())return;
    emit(CartLoadingState());
    // try{
      var res = await getAllCartListUseCase();
      res.fold((l) {
        emit(CartErrorState(errors: translate("toast.oops")));
      },(data) {
        cartList.clear();
        for(var i in data.sessionValue){
          cartList.add(ProductsEntity(title: "", catTitle: "",
              desc: "", id: i.productID,
              imgPath: "", price: i.price, discount: 0,discountRate: 0, stockStatus: true,
              quantity: i.quantity,categoryList: const [],commentCount: 0,catID: 0));
        }
        cartList = cartList;
        if(cartList.isNotEmpty)totalPrice=data.total;
        if(data.sessionID!=null)cartID=int.parse((data.sessionID??0).toString());
        emit(CartSuccessfullyState());
      });
    // }catch(e){
    //   debugPrint("getAllCartBloc: $e");
    //   emit(CartErrorState(errors: translate("toast.oops")));
    // }
  }

  calcTotal(){
    totalPrice = 0;
    for(var i in cartList){
      totalPrice = totalPrice + (i.price * i.quantity);
    }
    return totalPrice.toStringAsFixed(2);
  }

  addToCartList(AddToCartEvent event,emit)async{
    emit(CartLoadingState());
    try{
      var res = await addCartItemUseCase(data: GenerateCartJson.generate(productList: cartList,total: calcTotal().toString()));
      res.fold((l) {
        emit(CartErrorState(errors: translate("toast.oops")));
      },(data) {
        emit(AddToCartSuccessfullyState());
      });
    }catch(e){
      emit(CartErrorState(errors: translate("toast.oops")));
    }
  }

  removeToCartList(RemoveToCartEvent event,emit)async{
    emit(CartLoadingState());
    try{
      var res = await removeCartItemUseCase(productID: event.product.id);
      res.fold((l) {
        emit(CartErrorState(errors: l.toString()));
      },(data) {
        emit(RemoveCartSuccessfullyState());
      });
    }catch(e){
      emit(CartErrorState(errors: translate("toast.oops").toString()));
    }
  }

  modifyCartProduct(ModifyCartProductEvent event,emit)async{
    // emit(CartLoadingState());
    int index = cartList.indexWhere((element) => event.product.id.toString() == element.id.toString() || element.imgPath.trim() == event.product.imgPath.trim());
    if(index!=-1) {
      if(event.remove){
        cartList.removeAt(index);
      }else{
        var item = cartList[index];
        int newQty = event.isAdd?item.quantity+1:(item.quantity==1?item.quantity:item.quantity-1);
        item = ProductsEntity(title: event.product.title, catTitle: "",
            desc: "", id: item.id,discountRate: 0,
            imgPath: event.product.imgPath, price: event.product.price, discount: 0, stockStatus: true,
            quantity: newQty,categoryList: const [],commentCount: 0,catID: item.catID);
        cartList[index] = item;
      }
    }else{
      cartList.add(ProductsEntity(title: event.product.title, catTitle: "",
          desc: "", id: event.product.id,discountRate: 0,
          imgPath: event.product.imgPath, price: event.product.price, discount: 0, stockStatus: true,
          quantity: 1,categoryList: const [],commentCount: 0,catID:event.product.catID));
    }
    calcTotal();
    cartList = cartList;
    print(cartList.length);
    emit(CartSuccessfullyState());
    await Future.delayed(const Duration(seconds: 1));
    CartBloc.get(event.context).add(const AddToCartEvent());
  }

  int cartID = 0;
  double totalPrice = 200;
  double subTotal = 120;
  int shippingCost = 0;
  int minimumAmount = 0;
  double? couponValue;
  CouponModel? couponModel;

  getDiscountCoupon(ImplementCouponDiscountEvent event,emit)async {
    // emit(CartLoadingState());
    // try{
    //   var res = await applyCouponUseCase(dataSet: {'code':event.couponTxt.trim()});
    //   res.fold((l) {
    //     emit(CartErrorState(errors: translate("toast.oops")));
    //   },(data) {
    //     couponModel= data;
    //     if(couponModel!=null && couponModel!.total!=null && couponModel!.total != 0){
    //       couponValue = totalPrice - couponModel!.total!;
    //       totalPrice = couponModel!.total!;
    //       emit(CouponSuccessfullyState());
    //     }else{
    //       emit(CartErrorState(errors: translate("cart.couponـwrong")));
    //     }
    //   });
    // }catch(e){
    //   debugPrint("getDiscountCouponBloc: $e");
    //   emit(CartErrorState(errors: translate("toast.oops")));
    // }
  }

}
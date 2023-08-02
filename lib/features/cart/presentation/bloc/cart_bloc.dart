import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
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
    on<UpdateCartProductEvent>((event, emit) {
      updateProductQuantity(event,emit);
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
  List<ProductsEntity> cartList = [
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
  ];
  getAllCart(emit)async{
    // if(!Util.checkUser())return;
    // emit(CartLoadingState());
    // try{
    //   var res = await getAllCartListUseCase();
    //   res.fold((l) {
    //     emit(CartErrorState(errors: translate("toast.oops")));
    //   },(data) {
    //     cartList.clear();
    //     for(var i in data.sessionValue){
    //       cartList.add(ProductsEntity(title: "", catTitle: "",
    //           desc: "", id: i.productID,
    //           imgPath: "", price: 0, discount: 0,discountRate: 0, stockStatus: true,
    //           quantity: i.quantity,categoryList: const [],commentCount: 0));
    //     }
    //     if(cartList.isNotEmpty)totalPrice=data.total;
    //     if(data.sessionID!=null)cartID=int.parse((data.sessionKey??0).toString());
    //     emit(CartSuccessfullyState());
    //   });
    // }catch(e){
    //   debugPrint("getAllCartBloc: $e");
    //   emit(CartErrorState(errors: translate("toast.oops")));
    // }
  }


  List<Map<String,dynamic>> returnNewCartList(ProductsEntity item,emit){
    int index = cartList.indexWhere((element) => element.id==item.id);
    if(index!=-1) {
      cartList.removeAt(index);
      emit(RemoveCartSuccessfullyState());
    }else{
      cartList.add(item);
      emit(AddToCartSuccessfullyState());
    }
    return getCart();
  }

  List<Map<String,dynamic>> getCart(){
    List<Map<String,dynamic>> list = [];
    for(var i in cartList){
      list.add({'product_id':i.id,'quantity':i.quantity.toString()});
    }
    if(list.isEmpty){
      list.add({'product_id':0,'quantity':"0"});
    }
    return list;
  }

  addToCartList(AddToCartEvent event,emit)async{
    // emit(CartLoadingState());
    // var data = {
    //   'session_value':event.product!=null?returnNewCartList(event.product!,emit):getCart()
    // };
    // try{
    //   var res = await addCartItemUseCase(data: data);
    //   res.fold((l) {
    //     emit(CartErrorState(errors: translate("toast.oops")));
    //   },(data) {
    //     emit(AddToCartSuccessfullyState());
    //   });
    // }catch(e){
    //   emit(CartErrorState(errors: translate("toast.oops")));
    // }
  }

  removeToCartList(RemoveToCartEvent event,emit)async{
    // emit(CartLoadingState());
    // try{
    //   var res = await removeCartItemUseCase(productID: event.product.id);
    //   res.fold((l) {
    //     emit(CartErrorState(errors: l.toString()));
    //   },(data) {
    //     emit(RemoveCartSuccessfullyState());
    //   });
    // }catch(e){
    //   emit(CartErrorState(errors: translate("toast.oops").toString()));
    // }
  }

  updateProductQuantity(UpdateCartProductEvent event,emit){
    // emit(CartLoadingState());
    int index = cartList.indexWhere((element) => event.product.id.toString() == element.id.toString());
    if(index!=-1) {
      int newQty = event.isAdd?cartList[index].quantity+1:(cartList[index].quantity==1?cartList[index].quantity:cartList[index].quantity-1);
      cartList[index] = ProductsEntity(title: "", catTitle: "",
          desc: "", id: cartList[index].id,discountRate: 0,
          imgPath: "", price: 0, discount: 0, stockStatus: true,
          quantity: newQty,categoryList: const [],commentCount: 0);
    }else{
      cartList.add(ProductsEntity(title: "", catTitle: "",
          desc: "", id: event.product.id,discountRate: 0,
          imgPath: "", price: 0, discount: 0, stockStatus: true,
          quantity: 1,categoryList: const [],commentCount: 0));
    }
    cartList = cartList;
    emit(CartSuccessfullyState());
    CartBloc.get(event.context).add(const AddToCartEvent(addAllCurrentList: true));
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
// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/generat_cart_post_func.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
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
  PaymentEnum paymentWithCard = PaymentEnum.PAYFORT;
  bool applePay = false;
  bool deliveryAndInstallment = false;

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
      // await addToCartList(event,emit);
      // await getAllCart(emit);
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

    on<DeliveryWithInstallmentEvent>((event,emit){
      deliveryWithInstallmentMethod(event,emit);
    });

    on<PaymentWithCardEvent>((event,emit){
      changePaymentMethod(event,emit);
    });

    on<UpdateCountBeforeInsertInCart>((event,emit){
      updateCountBeforeInsertToCart(event,emit);
    });

    on<UpdateCountWidgetEvent>((event,emit){
      updateCurrentCountWidget(event,emit);
    });
  }
  static CartBloc get(BuildContext context) => BlocProvider.of(context);


  /// current count before add to cart (PRODUCT_DETAILS_PAGE)
  bool showCountWidget = false;
  int currentCartProductModify = 0;
  updateCurrentCountWidget(UpdateCountWidgetEvent event,emit){
    emit(CountWidgetLoadingState());
    showCountWidget = !showCountWidget;
    if(event.productId!=null)currentCartProductModify = event.productId!;
    emit(CountSuccessfullyState());
  }
  int currentCount = 1;
  updateCountBeforeInsertToCart(UpdateCountBeforeInsertInCart event,emit){
    emit(CountLoadingState());
    currentCount = event.value;
    emit(CountSuccessfullyState());
  }


  deliveryWithInstallmentMethod(DeliveryWithInstallmentEvent event,emit){
    emit(DeliveryLoadingState());
    deliveryAndInstallment = event.withInstallment;
    emit(DeliverySuccessfullyState());
  }

  changePaymentMethod(PaymentWithCardEvent event,emit){
    emit(PaymentLoadingState());
    paymentWithCard = event.paymentEnum;
    if(event.enableApplePay!=null)applePay = event.enableApplePay!;
    emit(PaymentSuccessfullyState());
  }
  int cartCount = 1;
  List<ProductsEntity> cartList = [];
  getAllCart(emit)async{
    if(!Util.checkUser())return;
    // emit(CartLoadingState());
    try{
      var res = await getAllCartListUseCase();
      res.fold((l) {
        emit(CartErrorState(errors: translate("toast.oops")));
      },(data) {
        cartList.clear();
        for(var i in data.sessionValue){
          cartList.add(ProductsEntity(title: i.title, catTitle: "",
              desc: "", id: i.productID,  sku: i.sku,
              imgPath: i.imgPath, price: i.price, discount: i.discount,discountRate: 0, stockStatus: true,
              quantity: i.quantity,categoryList: const [],commentCount: 0,catID: 0));
        }
        cartList = cartList;
        if(cartList.isNotEmpty) {
        totalPrice = data.total;
        total = totalPrice;
      }
      emit(CartSuccessfullyState());
      });
    }catch(e){
      debugPrint("getAllCartBloc: $e");
      emit(CartErrorState(errors: translate("toast.oops")));
    }
  }

  bool checkIFProductInsideCartList(ProductsEntity item){
    int index = cartList.indexWhere((element) => element.sku == item.sku);
    if(index!=-1)return true;
    return false;
  }

  ProductsEntity? getProductInCart(ProductsEntity item){
    int index = cartList.indexWhere((element) => element.sku == item.sku);
    if(index!=-1)return cartList[index];
    return null;
  }

  calcTotal(){
    totalPrice = 0;
    for(var i in cartList){
      totalPrice = totalPrice + (i.price * i.quantity);
    }
    couponModel = null;couponValue = null;
    total = totalPrice;
    return totalPrice.toStringAsFixed(2);
  }

  addToCart(emit,bool isRemoveProduct)async{
    var res = await addCartItemUseCase(data: GenerateCartJson.generate(productList: cartList,total: calcTotal().toString()));
    res.fold((l) {
      emit(CartErrorState(errors: translate("toast.oops")));
    },(data) {
      if(data){
        if(isRemoveProduct){
          emit(RemoveCartSuccessfullyState());
        }else{
          emit(AddToCartSuccessfullyState());
        }
      }
    });
  }


  modifyCartProduct(ModifyCartProductEvent event,emit)async{
    if(event.count!=null) emit(CartLoadingState());
    if(event.product!=null) {
      ///update current count after added last chooser count
      currentCount = 1;
      showCountWidget = false;
      checkItemAndModifyInsideCart(event.product!,event.remove,event.isAdd,count: event.count ?? -1);
    }else{
      //remove all cart when create new order
      cartList.clear();
    }
    calcTotal();
    cartList = cartList;
    if(event.count==null)emit(CartSuccessfullyState());
    await Future.delayed(const Duration(seconds: 1));
    await addToCart(emit,event.remove);
    await Future.delayed(const Duration(seconds: 1));
    await getAllCart(emit);
  }

  /// check product and add or update inside cart list
  checkItemAndModifyInsideCart(ProductsEntity product,bool remove,bool isAdd, {int? count}){
    int index = cartList.indexWhere((element) => product.sku == element.sku);
    if(index!=-1) {
      if(remove){
        cartList.removeAt(index);
      }else{
        var item = cartList[index];
        int newQty = count == -1? (isAdd?item.quantity+1:(item.quantity==1?item.quantity:item.quantity-1)) : count!;
        item = ProductsEntity(title: product.title,
            catTitle: "", sku: product.sku,
            desc: "", id: item.id,discountRate: 0,
            imgPath: product.imgPath, price: product.price,discount: product.discount, stockStatus: true,
            quantity: newQty,categoryList: const [],commentCount: 0,catID: item.catID);
        cartList[index] = item;
      }
    }else{
      cartList.add(ProductsEntity(title: product.title,
          catTitle: "", sku: product.sku,
          desc: "", id: product.id,discountRate: 0,
          imgPath: product.imgPath, price: product.price, discount: product.discount, stockStatus: true,
          quantity: count == -1 ? 1 : count!,categoryList: const [],commentCount: 0,catID:product.catID));
    }
  }

  double totalPrice = 0;
  double total = 0;
  double subTotal = 120;
  int shippingCost = 0;
  int minimumAmount = 0;
  double? couponValue;
  CouponModel? couponModel;
  getDiscountCoupon(ImplementCouponDiscountEvent event,emit)async {
    emit(CouponLoadingState());
    try{
      var res = await applyCouponUseCase(dataSet: {'code':event.couponTxt.trim()});
      res.fold((l) {
        emit(CartErrorState(errors: translate("toast.oops")));
      },(data) {
        couponModel= data;
        if(couponModel!=null && couponModel!.amount !=null && couponModel!.amount!=0 && couponModel!.code!=""){
          totalPrice = total;
          couponValue = couponModel!.amount!.toDouble();
          totalPrice = totalPrice - couponModel!.amount!.toDouble();
          emit(CouponSuccessfullyState());
        }else{
          emit(CartErrorState(errors: translate("cart.couponـwrong")));
        }
      });
    }catch(e){
      debugPrint("getDiscountCouponBloc: $e");
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

  Map<String,dynamic>? prepareCouponTamara(){
    if(couponModel!=null && couponModel!.amount !=null && couponModel!.amount!=0 && couponModel!.code!=""){
      return {
        "name": couponModel!.code,
        "amount": {
          "amount": couponModel!.amount.toString(),
          "currency": "SAR"
        }
      };
    }
    return null;
  }


  prepareProductsAsTamaraOrder(List<ProductsEntity> list){
    List<Map<String,dynamic>> products = [];
    for(var i in cartList){
      int index = list.indexWhere((element) => element.id == i.id);
      products.add(
          {
            "reference_id": i.id.toString(),
            "type": "Digital",
            "name": index == -1? "item" : list[index].title,
            "sku": index == -1? "item" : list[index].sku,
            "image_url": i.imgPath.toString(),
            "item_url": i.imgPath.toString(),
            "quantity": i.quantity,
            "unit_price": {
              "amount": i.price.toString(),
              "currency": "SAR"
            },
            "discount_amount": {
              "amount": i.discount.toString(),
              "currency": "SAR"
            },
            "tax_amount": {
              "amount": "${i.price-i.discount}",
              "currency": "SAR"
            },
            "total_amount": {
              "amount": "${i.price}",
              "currency": "SAR"
            }
          }
      );
    }
    return products;
  }

  addToCartInView({required BuildContext context,required var bloc,required var item,required bool insideCartList,int? val}){
    if(!Util.checkUser()){
      SnackBarBuilder.showFeedBackMessage(context, translate("toast.login"), DMUtil.getRED(),isMarginBottom: true);
      return;
    }
    bloc.add(ModifyCartProductEvent(product: item, context: context, isAdd: true,remove: insideCartList,count: val ?? currentCount));
  }

}
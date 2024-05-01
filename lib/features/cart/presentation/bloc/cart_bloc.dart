// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_sdk.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/cart/domain/use_cases/cart_usecase.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';




class CartBloc extends Bloc<CartEvent,CartState>{
  int currentCategoryIndex = 0;
  PaymentEnum paymentWithCard = PaymentEnum.PAYFORT;
  bool applePay = false;
  bool deliveryAndInstallment = false;

  AddCartItemUseCase addCartItemUseCase;
  GetAllCartListUseCase getAllCartListUseCase;
  RemoveCartItemUseCase removeCartItemUseCase;
  ApplyCouponUseCase applyCouponUseCase;  
  CartBloc({
    required this.getAllCartListUseCase,
    required this.addCartItemUseCase,
    required this.removeCartItemUseCase,
    required this.applyCouponUseCase,
  }) : super(const CartInitialState()) {
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
      await getTamaraMAxAmount(emit);
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
      emit(const CartLoadingState());
      cartCount = event.value;
      emit(const CartSuccessfullyState());
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


  double tamaraMax = 5000;
  getTamaraMAxAmount(emit)async{
    emit(const CartSuccessfullyState());
    tamaraMax = await TamaraSdk.getTamaraAmountLimit();
    emit(const CartSuccessfullyState());
  }


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
    if(event.enableApplePay!=null){
      applePay = event.enableApplePay!;
    }else{
      applePay = false;
    }
    emit(PaymentSuccessfullyState());
  }

  int cartCount = 1;
  List<ProductsEntity> cartList = [];
  getAllCart(emit)async{
    emit(const CartLoadingState());
    try{
      cartList = _getLocalCartList();
      calcTotal();
      emit(const CartSuccessfullyState());
      // var res = await getAllCartListUseCase();
      // res.fold((l) {
      //   emit(CartErrorState(errors: translate("toast.oops")));
      // },(data) {
      //   cartList.clear();
      //   for(var i in data.sessionValue){
      //     cartList.add(ProductsEntity(title: i.title, catTitle: "",
      //         desc: "", id: i.productID,  sku: i.sku,
      //         imgPath: i.imgPath, price: i.price, discount: i.discount,discountRate: 0, stockStatus: true,
      //         quantity: i.quantity,categoryList: const [],commentCount: 0,catID: 0));
      //   }
      //   cartList = cartList;
      //   if(cartList.isNotEmpty) {
      //   totalPrice = data.total;
      //   total = totalPrice;
      // }
      // emit(CartSuccessfullyState());
      // });
    }catch(e){
      debugPrint("getAllCartBloc: $e");
      emit(CartErrorState(errors: translate("toast.oops")));
    }
  }

  /// get cart list [local]
  List<ProductsEntity> _getLocalCartList(){
    try{
      if(!SharedPref().containPreference(Constants.allLocalCartList))return [];
      String data =  SharedPref().getPreferenceString(Constants.allLocalCartList);
      List<dynamic> decodedList = json.decode(data);
      List<ProductsEntity> list = decodedList
          .map((product) => ProductsEntity.fromJsonLocal(product))
          .toList();
      return list;
    }catch(e){
      debugPrint("_getLocalCartList: $e");
      return [];
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

  calcTotal({bool setCouponNull = false}){
    if(setCouponNull) {
      couponModel = null;
      couponValue = null;
    }
    totalPrice = 0;
    totalProducts = 0;
    for(var i in cartList){
      totalProducts = totalProducts + (i.priceWithoutTax * i.quantity);
    }
    if(couponModel!=null&&couponModel!.amount!=null) {
      if(couponModel!.isPercent==true){
        double c = couponModel!.amount! / 100;
        couponValue = double.parse(totalProducts.toString()) * c;
        totalProducts = totalProducts - couponValue!;
      }else{
        couponValue = couponModel!.amount!.toDouble();
        totalProducts = totalProducts - couponModel!.amount!;
      }
    }
    double valV = (totalProducts * 0.15).toDouble();
    vatValue = double.tryParse(valV.toStringAsFixed(2)) ?? valV;
    totalPrice = totalProducts + vatValue;
    total = totalPrice;
    totalPrice = double.tryParse(total.toStringAsFixed(2)) ?? total;
    return totalPrice.toStringAsFixed(3);
  }

  addToCart(emit,bool isRemoveProduct,)async{
    updateCartList(emit,cartList,isRemoveProduct);
    // var res = await addCartItemUseCase(data: GenerateCartJson.generate(productList: cartList,total: calcTotal().toString()));
    // res.fold((l) {
    //   emit(CartErrorState(errors: translate("toast.oops")));
    // },(data) {
    //   if(data){
    //     if(isRemoveProduct){
    //       emit(RemoveCartSuccessfullyState());
    //     }else{
    //       emit(AddToCartSuccessfullyState());
    //     }
    //   }
    // });
  }

  /// add and update cart list [local]
  updateCartList(emit,List<ProductsEntity> list,bool isRemoveProduct){
    try{
      SharedPref().removePreference(Constants.allLocalCartList);
      String encodedList = json.encode(list
          .map((product) => ProductsEntity.toJsonLocal(product))
          .toList());
      SharedPref().setPreferencesString(Constants.allLocalCartList,encodedList);
      cartList = _getLocalCartList();
      if(isRemoveProduct){
        emit(RemoveCartSuccessfullyState());
      }else{
        emit(AddToCartSuccessfullyState());
      }
    }catch(e){
      debugPrint("updateCartList: $e");
      emit(CartErrorState(errors: translate("toast.oops")));
    }
  }


  modifyCartProduct(ModifyCartProductEvent event,emit)async{
    if(event.count!=null) emit(const CartLoadingState());
    if(event.product!=null) {
      ///update current count after added last chooser count
      currentCount = 1;
      showCountWidget = false;
      checkItemAndModifyInsideCart(product: event.product!,remove: event.remove,count: event.count ?? -1);
      checkIfProductXHasProductYFree(product: event.product!,remove: event.remove,count: event.count ?? -1,context: event.context);
    }else{
      //remove all cart when create new order
      cartList.clear();
    }
    calcTotal(setCouponNull: true);
    cartList = cartList;
    if(event.count==null)emit(const CartSuccessfullyState());
    await addToCart(emit,event.remove);
    await getAllCart(emit);
  }

  /// check product and add or update inside cart list
  checkItemAndModifyInsideCart({required ProductsEntity product,required remove,int? count,bool isFree = false}){
    int index = cartList.indexWhere((element) => product.sku == element.sku);
    if(index!=-1) {
      if(remove){
        cartList.removeAt(index);
      }else{
        var item = cartList[index];
        int newQty = count!=null && count != -1? count : item.quantity+1;
        item = ProductsEntity(title: product.title,
            catTitle: "", sku: product.sku,
            desc: "", id: item.id,discountRate: 0,
            imgPath: product.imgPath,
            price: isFree? 0 : product.price,
            priceWithoutTax: isFree? 0 : product.priceWithoutTax,
            discount: isFree? 0 : product.discount, stockStatus: true,
            quantity: newQty,categoryList: const [],commentCount: 0,catID: item.catID);
        cartList[index] = item;
      }
    }else{
      cartList.add(ProductsEntity(title: product.title,
          catTitle: "", sku: product.sku,
          desc: "", id: product.id,discountRate: 0,
          priceWithoutTax: isFree? 0 : product.priceWithoutTax,
          imgPath: product.imgPath,
          price: isFree? 0 : product.price, 
          discount: isFree? 0 : product.discount, stockStatus: true,
          quantity: count == -1 ? 1 : count!,categoryList: const [],commentCount: 0,catID:product.catID));
    }
  }

  double totalProducts = 0;
  double totalPrice = 0;
  double total = 0;
  double subTotal = 120;
  int shippingCost = 0;
  double vatValue = 0;
  int minimumAmount = 0;
  double? couponValue;
  CouponModel? couponModel;
  getDiscountCoupon(ImplementCouponDiscountEvent event,emit)async {
    emit(const CouponLoadingState());
    try{
      var res = await applyCouponUseCase(dataSet: {'code':event.couponTxt.trim()});
      res.fold((l) {
        emit(CartErrorState(errors: translate("toast.oops")));
      },(data) {
        couponModel= data.couponModel;
        if(checkCouponValue(couponModel)){
          calcTotal(setCouponNull: false);
          emit(const CouponSuccessfullyState());
        }else{
          calcTotal(setCouponNull: true);
          emit(CartErrorState(errors: data.msg));
        }
      });
    }catch(e){
      debugPrint("getDiscountCouponBloc: $e");
      emit(CartErrorState(errors: translate("toast.oops")));
    }
  }

  bool checkCouponValue(CouponModel? couponModel){
    return couponModel!=null && couponModel.amount !=null && couponModel.amount!=0 && couponModel.code!="";
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

  addToCartInView({required BuildContext context,required var bloc,required var item,int? val}){
    // if(!Util.checkUser()){
    //   SnackBarBuilder.showFeedBackMessage(context, translate("toast.login"), DMUtil.getRED(),isMarginBottom: true);
    //   return;
    // }
    bloc.add(ModifyCartProductEvent(product: item, context: context, isAdd: true,count: val ?? currentCount));
  }

   ///[discount_and_rules] section
   checkIfProductXHasProductYFree({required ProductsEntity product,required remove,required BuildContext context,int? count}){
    var productsBloc = ProductsBloc.get(context);
    var dealsList =  productsBloc.productsDeals;
    for(var i in dealsList){
      if(i.buyXGetYFree!=null && i.buyXGetYFree!.isNotEmpty && ((Util.getLang()=="ar"&&i.isArabic==true) || (Util.getLang()=="en_US"&&i.isArabic==false))){
        if(i.mainProducts==null || i.mainProducts!.isEmpty)return;
        int productIndex = i.mainProducts!.indexWhere((element) => element.toString() == product.id.toString());
        if(productIndex!=-1){
          for(var y in i.buyXGetYFree!){
            int freeProductindex = productsBloc.productsList.indexWhere((element) => y.toString() == element.id.toString());
            if(freeProductindex == -1)return;
            checkItemAndModifyInsideCart(product: productsBloc.productsList[freeProductindex],count: count,remove: remove,isFree: true);
          }
        }
      }
    }
   }

}
// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/amwal/ui/amwal_widgets.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_web_view.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:awad_nahas/features/order/presentation/screens/order_screen.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pay/pay.dart';
import 'package:awad_nahas/core/utils/payment_utils/apple_pay/payment_configurations.dart'  as payment_configurations;
import 'package:awad_nahas/core/utils/payment_utils/payment_controller.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_sdk.dart';


class CheckOutButton extends StatefulWidget {
  const CheckOutButton({Key? key}) : super(key: key);

  @override
  State<CheckOutButton> createState() => _CheckOutButtonState();
}

class _CheckOutButtonState extends State<CheckOutButton> {
  PayFortController payFortController =  PayFortController();
  late CartBloc cartBloc;
  late LocationsBloc locationsBloc;

  @override
  void initState() {
    cartBloc = CartBloc.get(context);
    locationsBloc = LocationsBloc.get(context);
    cartBloc.paymentWithCard == PaymentEnum.PAYFORT;
    paymentItems = [
      PaymentItem(
        label: translate("cart.total_price"),
        amount: cartBloc.totalPrice.toString(),
        status: PaymentItemStatus.final_price,
      )
    ];
    super.initState();
  }
  var paymentItems = const [
    PaymentItem(
      label: 'Total',
      amount: '10.0',
      status: PaymentItemStatus.final_price,
    )
  ];
  @override
  void didChangeDependencies() {
    if(mounted){
      locationsBloc.checkLocation(context);
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc,OrderState>(
      listenWhen: (ctx,state)=> state is AssignOrderSuccessfullyState || state is OrderErrorState,
      listener: (ctx,state)async{
        if(state is AssignOrderSuccessfullyState){
          cartBloc.add(ModifyCartProductEvent(product: null, isAdd: false, context: context));
          CustomDialogs.thanksOrder(context);
          await Future.delayed(const Duration(seconds: 2));
          Navigator.of(context).pop();
          RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
          Util.pushPageAndRemoveRoutes(const RootScreen(), context);
          Util.pushPage(const OrderScreen(), context);
        }
        if(state is OrderErrorState){
          SnackBarBuilder.showFeedBackMessage(context, translate("toast.oops"), Colors.red);
        }
      },
      child: BlocBuilder<OrderBloc,OrderState>(
        builder: (ctx,orderState){
          var orderBloc = OrderBloc.get(ctx);
          return SizedBox(
            height: 125.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if(cartBloc.cartList.isNotEmpty)...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "${cartBloc.cartList.length} ${cartBloc.cartList.length>1?translate("store.items"):translate("store.item")}",
                        fontSize: AppStyle.average.sp,
                        color: DMUtil.getD2C().withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: "${cartBloc.totalPrice.toStringAsFixed(2)} ${translate("store.sar")}",
                        fontSize: AppStyle.average.sp,
                        color: DMUtil.getD2C(),
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                ],
                QuickCheckOutButton(amount: cartBloc.totalPrice, list: cartBloc.cartList,height: 35,),
                const SizedBox(height: 5,),
                BlocBuilder<CartBloc,CartState>(
                  builder: (ctx,state){
                    if(orderState is OrderLoadingState)return Center(child: CircularProgressIndicator(color: DMUtil.getPC(),),);
                    var cartBloc = CartBloc.get(ctx);
                    return Padding(
                      padding: const EdgeInsets.all(0),
                      child: Stack(
                        children: [
                          if(cartBloc.applePay)...[
                            ApplePayButton(
                              height: 45.h,
                              width: double.infinity,
                              paymentConfiguration: PaymentConfiguration.fromJsonString(
                                  payment_configurations.defaultApplePay),
                              paymentItems: paymentItems,
                              style: ApplePayButtonStyle.black,
                              type: ApplePayButtonType.checkout,
                              onPaymentResult: (val) async {
                                List<LocationEntity> locations = locationsBloc.checkLocation(context);
                                if(locations.isEmpty){
                                  SnackBarBuilder.showFeedBackMessage(context, translate("toast.location_mis"), DMUtil.getRED());
                                  return;
                                }
                                await onApplePayResult(val,orderBloc);
                              },
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ]else...[
                            CustomButton(
                              height: 45.h,
                              width: double.infinity,
                              circular: 10,
                              widget: state is OrderLoadingState ?
                              const CircularProgressIndicator(color: Colors.white,):
                              CustomText(
                                text: translate("cart.complete_payment"),
                                color: Colors.white,
                                fontSize: AppStyle.average.sp,
                                alignCenter: true,
                                fontWeight: FontWeight.w600,
                              ),
                              color: DMUtil.getRED(),
                              onPressed: () async => await _checkOut(context,orderBloc),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  onApplePayResult(paymentResult,OrderBloc orderBloc) async{
    // debugPrint("result: ${paymentResult.toString()}");
    // debugPrint(paymentResult['token']);
    // SnackBarBuilder.showFeedBackMessage(context, paymentResult['token'].toString(), DMUtil.getRED());
    // SnackBarBuilder.showFeedBackMessage(context, paymentResult.toString(), DMUtil.getRED());
    // debugPrint(paymentResult['token']['signature']);
    // debugPrint(paymentResult['token']['header']);
    // debugPrint(paymentResult['token']['header']['transactionId']);
    // debugPrint(paymentResult['token']['data']);
    // debugPrint(paymentResult['paymentMethod']['network']);
    await _checkOutApplePay(orderBloc,paymentResult);
  }

  _checkOut(BuildContext context,OrderBloc orderBloc)async{
    if(cartBloc.paymentWithCard == PaymentEnum.CASH){
      SnackBarBuilder.showFeedBackMessage(context, translate("toast.wrong_payment"), DMUtil.getRED());
      // _cash(orderBloc);
    }else if(cartBloc.paymentWithCard == PaymentEnum.PAYFORT){
        _checkOutAmazonPayfort(orderBloc);
    }else if(cartBloc.paymentWithCard == PaymentEnum.TAMARA){
      _checkOutTamra(context,orderBloc);
    }
  }

  // _cash(var orderBloc)async{
  //   orderBloc.add(AddOrderEvent(list: cartBloc.cartList, totalPrice: cartBloc.totalPrice));
  // }

  //+966 508443655
  // 502441695
  //Checkout1!
  _checkOutTamra(BuildContext context,OrderBloc orderBloc) async {
    List<LocationEntity> locations = locationsBloc.checkLocation(context);
    if(locations.isEmpty){
      SnackBarBuilder.showFeedBackMessage(context, translate("toast.location_mis"), DMUtil.getRED());
      return;
    }
    var billing = locations.first;
    var shipping = locations.last;
    var bloc = ProductsBloc.get(context);
    List<ProductsEntity> list = bloc.productsList;
    final checkCoupon = cartBloc.prepareCouponTamara();
    final checkOutUrl = await TamaraSdk.checkOut(data: {
      "total_price":cartBloc.totalPrice,
      "items":cartBloc.prepareProductsAsTamaraOrder(list),
      "billing_address":LocationModel.toJson(billing),
      "shipping_address":LocationModel.toJson(shipping),
      if(checkCoupon!=null)"discount": checkCoupon
    },context: context);
    if(checkOutUrl!=null){
      final res = await Util.pushPage(TamaraCheckout(
        checkOutUrl,
        ApiUrl.MAIN_DOMAIN,
        "${ApiUrl.MAIN_DOMAIN}/en/?pagename=tamara-payment-fail",
        "${ApiUrl.MAIN_DOMAIN}/en/?pagename=tamara-payment-cancel",
        onPaymentSuccess: () {
          debugPrint("onPaymentSuccess");
        },
        onPaymentFailed: () {
          debugPrint("onPaymentFailed");
        },
        onPaymentCanceled: () {
          debugPrint("onPaymentCanceled");
        },
      ), context);
      debugPrint("res: $res");
      if(res=="successful"){
        orderBloc.add(AddOrderEvent(list: cartBloc.cartList, totalPrice: cartBloc.totalPrice,context: context,payment:PaymentOption(paymentEnum: cartBloc.paymentWithCard),
            couponModel: cartBloc.couponModel==null || cartBloc.checkCouponValue(cartBloc.couponModel!)==false?null:cartBloc.couponModel,
            couponVal:  cartBloc.couponValue??0,taxTotal: cartBloc.vatValue),);
      }else{
        SnackBarBuilder.showFeedBackMessage(context, translate("toast.wrong_payment"), DMUtil.getRED());
      }
    }
  }

  _checkOutApplePay(OrderBloc orderBloc,Map<String,dynamic> appleData)async{
    try{
      final res = await payFortController.flutterAmazonApplePay(amount: cartBloc.totalPrice.toInt(),appleData: appleData);
      if(res=="true"){
        SnackBarBuilder.showFeedBackMessage(context, res.toString(), DMUtil.getRED());
        orderBloc.add(AddOrderEvent(list: cartBloc.cartList, totalPrice: cartBloc.totalPrice,context: context,payment:PaymentOption(paymentEnum: cartBloc.paymentWithCard,isApplePay: true)));
      }else{
        SnackBarBuilder.showFeedBackMessage(context, res.toString(), DMUtil.getRED());
      }
    }catch(e){
      SnackBarBuilder.showFeedBackMessage(context, e.toString(), DMUtil.getRED());
    }
  }

  _checkOutAmazonPayfort(OrderBloc orderBloc)async{
    List<LocationEntity> locations = locationsBloc.checkLocation(context);
    if(locations.isEmpty){
      SnackBarBuilder.showFeedBackMessage(context, translate("toast.location_mis"), DMUtil.getRED());
      return;
    }
    final res = await payFortController.flutterAmazon(amount: cartBloc.totalPrice.toInt());
    if(res.check && res.res != null){
       orderBloc.add(AddOrderEvent(list: cartBloc.cartList, totalPrice: cartBloc.totalPrice,context: context,
           payment:PaymentOption(paymentEnum: cartBloc.paymentWithCard),apsData: res.res,
           couponModel: cartBloc.couponModel==null ||  cartBloc.checkCouponValue(cartBloc.couponModel!)==false?null:cartBloc.couponModel,
           couponVal:  cartBloc.couponValue??0,taxTotal: cartBloc.vatValue));
    }else{
      SnackBarBuilder.showFeedBackMessage(context, translate("toast.wrong_payment"), DMUtil.getRED());
    }
  }

}
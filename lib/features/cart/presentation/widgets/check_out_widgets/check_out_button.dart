// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/amwal/ui/amwal_widgets.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_web_view.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/generat_cart_post_func.dart';
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
import 'package:awad_nahas/core/utils/payment_utils/payment_controller.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_sdk.dart';


class CheckOutButton extends StatefulWidget {
  const CheckOutButton({super.key});

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
    super.initState();
  }
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
      listenWhen: (ctx,state) => state is SendPendingOrderSuccessfullyState || state is AssignOrderSuccessfullyState || state is OrderErrorState ,
      listener: (ctx,state)async{
        var orderBloc = OrderBloc.get(ctx);
        if(state is AssignOrderSuccessfullyState && state.payment.paymentEnum != PaymentEnum.AMWAL){
          cartBloc.add(ModifyCartProductEvent(product: null, isAdd: false, context: context));
          CustomDialogs.thanksOrder(context);
          await Future.delayed(const Duration(seconds: 2));
          Navigator.of(context).pop();
          RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
          Util.pushPageAndRemoveRoutes(const RootScreen(), context);
          Util.pushPage(const OrderScreen(), context);
        }

        /// pay after the order set as pending
        if(state is SendPendingOrderSuccessfullyState && state.payment.paymentEnum != PaymentEnum.AMWAL){
          if(cartBloc.paymentWithCard == PaymentEnum.CASH){
            SnackBarBuilder.showFeedBackMessage(context, translate("toast.wrong_payment"), DMUtil.getRED());
          }else if(cartBloc.paymentWithCard == PaymentEnum.PAYFORT){
            _checkOutAmazonPayfort(orderBloc,state.orderID);
          }else if(cartBloc.paymentWithCard == PaymentEnum.TAMARA){
            _checkOutTamra(context,orderBloc,state.orderID);
          }
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
                QuickCheckOutButton(amount: cartBloc.totalPrice, list: cartBloc.cartList,height: 35,amWalListen: false,),
                const SizedBox(height: 5,),
                BlocBuilder<CartBloc,CartState>(
                  builder: (ctx,state){
                    if(orderState is OrderLoadingState)return Center(child: CircularProgressIndicator(color: DMUtil.getPC(),),);
                    return CustomButton(
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

  _checkOut(BuildContext context,OrderBloc orderBloc)async{
    orderBloc.setPendingOrder(orderBloc,cartBloc,context,PaymentOption(paymentEnum: cartBloc.paymentWithCard));
  }

  //+966 508443655
  // 502441695
  //Checkout1!
  _checkOutTamra(BuildContext context,OrderBloc orderBloc,String orderID) async {
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
      if(checkCoupon!=null)"discount": checkCoupon,
      "order_id":orderID
    },context: context);

    if(checkOutUrl!=null){
      await Util.pushPage(TamaraCheckout(
        checkOutUrl,
        ApiUrl.MAIN_DOMAIN,
        "${ApiUrl.MAIN_DOMAIN}/en/?pagename=tamara-payment-fail",
        "${ApiUrl.MAIN_DOMAIN}/en/?pagename=tamara-payment-cancel",
        onPaymentSuccess: (){
          debugPrint("onPaymentSuccess");
          orderBloc.add(AddOrderEvent(list: cartBloc.cartList, totalPrice: cartBloc.totalPrice,context: context,payment:PaymentOption(paymentEnum: cartBloc.paymentWithCard),
            couponModel: cartBloc.couponModel==null || cartBloc.checkCouponValue(cartBloc.couponModel!)==false?null:cartBloc.couponModel,
            couponVal:  cartBloc.couponValue??0,taxTotal: cartBloc.vatValue,
            orderStatus: WCStatusKey.wc_processing,
          ));
        },
        onPaymentFailed: () {
          debugPrint("onPaymentFailed");
          SnackBarBuilder.showFeedBackMessage(context, translate("toast.wrong_payment"), DMUtil.getRED());
          orderBloc.trackOrder({'order_data':"user: ${Util.getUserID()},${Util.getUserLogin()}<br/>payTamara: onPaymentFailed<br/>orderData: ${GenerateCartJson.getListAsString(cartBloc.cartList).toString()}<br/>total: ${cartBloc.totalPrice}"});
        },
        onPaymentCanceled: () {
          debugPrint("onPaymentCanceled");
          SnackBarBuilder.showFeedBackMessage(context, translate("toast.wrong_payment"), DMUtil.getRED());
          orderBloc.trackOrder({'order_data':"user: ${Util.getUserID()},${Util.getUserLogin()}<br/>payTamara: onPaymentCanceled<br/>orderData: ${GenerateCartJson.getListAsString(cartBloc.cartList).toString()}<br/>total: ${cartBloc.totalPrice}"});
        },
      ), context);
    }
  }

  _checkOutAmazonPayfort(OrderBloc orderBloc,String orderID)async{
    List<LocationEntity> locations = locationsBloc.checkLocation(context);
    if(locations.isEmpty){
      SnackBarBuilder.showFeedBackMessage(context, translate("toast.location_mis"), DMUtil.getRED());
      return;
    }
    final res = await payFortController.flutterAmazon(amount: cartBloc.totalPrice.toInt(),orderID: orderID);
    if(res.check && res.res != null){
       orderBloc.add(AddOrderEvent(list: cartBloc.cartList, totalPrice: cartBloc.totalPrice,context: context,
           payment:PaymentOption(paymentEnum: cartBloc.paymentWithCard),apsData: res.res,
           couponModel: cartBloc.couponModel==null ||  cartBloc.checkCouponValue(cartBloc.couponModel!)==false?null:cartBloc.couponModel,
           couponVal:  cartBloc.couponValue??0,taxTotal: cartBloc.vatValue,
           orderStatus: WCStatusKey.wc_processing
       ));
    }else{
      SnackBarBuilder.showFeedBackMessage(context, translate("toast.wrong_payment"), DMUtil.getRED());
      orderBloc.trackOrder({'order_data':"user: ${Util.getUserID()},${Util.getUserLogin()}<br/>payPayfort: ${res.msg}<br/>orderData: ${GenerateCartJson.getListAsString(cartBloc.cartList).toString()}<br/>total: ${cartBloc.totalPrice}"});
    }
  }
}
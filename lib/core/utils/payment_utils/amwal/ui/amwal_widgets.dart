// // ignore_for_file: use_build_context_synchronously

// import 'package:awad_nahas/core/strings/enum/order_enum.dart';
// import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
// import 'package:awad_nahas/core/styles/app_style.dart';
// import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
// import 'package:awad_nahas/core/utils/payment_utils/amwal/proccess.dart';
// import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
// import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
// import 'package:awad_nahas/features/cart/presentation/bloc/generat_cart_post_func.dart';
// import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
// import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
// import 'package:awad_nahas/features/locations/presentation/screens/my_locations.dart';
// import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
// import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
// import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
// import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
// import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
// import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
// import 'package:awad_nahas/core/utils/small_fun.dart';
// import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
// import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
// import 'package:awad_nahas/features/order/presentation/screens/order_screen.dart';
// import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
// import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class QuickCheckOutButton extends StatelessWidget {
//   final double width;
//   final double height;
//   final double amount;
//   final List<ProductsEntity> list;
//   final bool? amWalListen;
//   final BuildContext? ctX;
//   const QuickCheckOutButton({super.key,this.height = 32,this.width = double.infinity,required this.amount,required this.list,required this.amWalListen,this.ctX});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartBloc,CartState>(
//       builder: (ctx,cartState){
//         var cartBloc = CartBloc.get(ctx);
//         return BlocListener<OrderBloc,OrderState>(
//           listenWhen: (ctx,state)=>  state is SendPendingOrderSuccessfullyState || state is AssignOrderSuccessfullyState  || state is OrderErrorState,
//           listener: (ctx,state)async{
//             var orderBloc = OrderBloc.get(ctx);
//             if(state is AssignOrderSuccessfullyState && state.payment.paymentEnum == PaymentEnum.AMWAL){
//               CartBloc.get(context).add(ModifyCartProductEvent(product: null, isAdd: false, context: context));
//               CustomDialogs.thanksOrder(context);
//               await Future.delayed(const Duration(seconds: 2));
//               Util.pushPageAndRemoveRoutes(const RootScreen(), ctX ?? context);
//               Util.pushPage(const OrderScreen(), ctX ?? context);
//             }

//             // /// pay after the order set as pending
//             if(state is SendPendingOrderSuccessfullyState && state.payment.paymentEnum == PaymentEnum.AMWAL){
//               if (orderBloc.amwalIsOpen) {
//                   debugPrint("render amwal widget ${orderBloc.amwalIsOpen} ${state.orderID}");
//                   orderBloc.amwalIsOpen = false;
//                   final res = await AmWalPlugin.pay(amount, state.orderID);
//                       if(res.success){
//                 orderBloc.add(AddOrderEvent(list: list, totalPrice: amount, context: context,
//                     payment: const PaymentOption(paymentEnum: PaymentEnum.AMWAL,isApplePay: false),
//                     amWalTransactionId: res.transactionId.toString(),
//                     couponModel: cartBloc.couponModel ==null || cartBloc.checkCouponValue(cartBloc.couponModel!)==false?null:cartBloc.couponModel,
//                     couponVal: cartBloc.couponValue??0,
//                     taxTotal: cartBloc.vatValue,
//                     orderStatus: WCStatusKey.wc_processing
//                 ));
//               }else{
//                 SnackBarBuilder.showFeedBackMessage(context, res.msg, Colors.red);
//                 orderBloc.trackOrder({'order_data':"user: ${Util.getUserID()},${Util.getUserLogin()}<br/>payQuickCheckOut: ${res.msg},${res.transactionId},${res.canceled==true?"canceled":(res.success==true?"success":"failed")}<br/>orderData: ${GenerateCartJson.getListAsString(cartBloc.cartList).toString()}<br/>total: $amount"});
//               }
//                orderBloc.add(const AmwalCheckOpening(isOpen: false));
//               }             
//             }

//             if(state is OrderErrorState){
//               SnackBarBuilder.showFeedBackMessage(context, translate("toast.oops"), Colors.red);
//             }
//           },
//           child: BlocBuilder<OrderBloc,OrderState>(
//             builder: (ctx,state){
//               var orderBloc = OrderBloc.get(ctx);
//               if(state is OrderLoadingState && amWalListen == true)return Center(child: CircularProgressIndicator(color: DMUtil.getDC(),),);
//               return CustomButton(
//                 color: DMUtil.getDC(),
//                 width: width,
//                 height: height.w,
//                 widget: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.payment,size: 15.w,color: DMUtil.getWC(),),
//                     const SizedBox(width: 10,),
//                     const Text("|",style: TextStyle(color: Colors.white),),
//                     const SizedBox(width: 10,),
//                     CustomText(
//                       text: translate("payment.quick_checkout"),
//                       fontSize: AppStyle.small.sp,
//                       fontWeight: FontWeight.w600,
//                       color: DMUtil.getWC(),
//                     ),
//                   ],
//                 ),
//                 onPressed: ()async{
//                   if(!Util.checkUser()){
//                     SnackBarBuilder.showFeedBackMessage(context, translate("toast.login"), DMUtil.getRED(),);
//                     Util.pushPage(const LoginScreen(), context);
//                     return;
//                   }
//                   List<LocationEntity> locations = LocationsBloc.get(context).checkLocation(context);
//                   if(locations.isEmpty){
//                     Util.pushPage(const MyLocationsScreen(), context);
//                     SnackBarBuilder.showFeedBackMessage(context, translate("toast.location_mis"), DMUtil.getRED());
//                     return;
//                   }
//                   orderBloc.add(const AmwalCheckOpening(isOpen: true));
//                   _setPendingOrder(orderBloc, cartBloc, context);
//                 },
//               );
//             },
//           ),
//         );
//       },
//     );
//   }


//   /// save order as pending before payment process
//   _setPendingOrder(OrderBloc orderBloc,CartBloc cartBloc,BuildContext context){
//     orderBloc.add(AddOrderEvent(list: list, totalPrice: amount, context: context,
//         payment: const PaymentOption(paymentEnum: PaymentEnum.AMWAL,isApplePay: false),
//         amWalTransactionId: "",
//         couponModel: cartBloc.couponModel ==null || cartBloc.checkCouponValue(cartBloc.couponModel!)==false?null:cartBloc.couponModel,
//         couponVal: cartBloc.couponValue??0,
//         taxTotal: cartBloc.vatValue,
//         orderStatus: WCStatusKey.wc_pending
//     ));
//   }
// }
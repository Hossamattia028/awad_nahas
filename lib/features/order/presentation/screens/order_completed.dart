// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:awad_nahas/core/styles/app_style.dart';
// import 'package:awad_nahas/core/styles/my_colors.dart';
// import 'package:awad_nahas/core/utils/small_fun.dart';
// import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
// import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
// import 'package:awad_nahas/features/order/presentation/widgets/status_bar.dart';
// import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
// import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
// import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
// import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
// import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
//
// class OrderCompletedScreen extends StatelessWidget {
//   const OrderCompletedScreen({Key? key,}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
//         child: BlocBuilder<OrderBloc,OrderState>(
//           builder: (ctx,state){
//             var bloc = OrderBloc.get(ctx);
//             var lastOrder = bloc.orderList.last;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: AppStyle.paddingFromTop.h+50,),
//                 CustomText(
//                   text: "${translate("order.thanks_for_order")} ${Util.getName()}",
//                   color: kText1,
//                   fontSize: AppStyle.average.sp,
//                   fontWeight: FontWeight.w700,
//                 ),
//
//                 CustomText(
//                   text: translate("order.order_confirmed"),
//                   color: kText1,
//                   fontSize: AppStyle.large.sp,
//                   fontWeight: FontWeight.w700,
//                 ),
//
//                 CustomText(
//                   text: "${translate("order.will_send_email")} ${Util.getEmail()} ${translate("order.when_confirmed")}",
//                   color: kText1,
//                   fontSize: AppStyle.small.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomText(
//                       text: translate("order.order_number"),
//                       color: kText1,
//                       fontSize: AppStyle.average.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     CustomText(
//                       text: "#${lastOrder.orderId}",
//                       color: kText1,
//                       fontSize: AppStyle.average.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     StatusBarWidget(txt: translate("order.pending"), isEnabled: true),
//                     StatusBarWidget(txt: translate("order.in_progress"), isEnabled: false),
//                     StatusBarWidget(txt: translate("order.received"), isEnabled: false),
//                   ],
//                 ),
//                 const SizedBox(height: 10,),
//
//                 CustomButton(
//                   height: 40.h,
//                   width: double.infinity,
//                   circular: 2,
//                   widget: CustomText(
//                     text: translate("cart.continue_shopping").toUpperCase(),
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: AppStyle.average.sp,
//                   ),
//                   color: kBackBlueColor,
//                   onPressed: (){
//                     RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
//                     Util.pushPageAndRemoveRoutes(const RootScreen(), context);
//                   },
//                 ),
//
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//

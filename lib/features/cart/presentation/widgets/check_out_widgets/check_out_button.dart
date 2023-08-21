import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/payment_controller.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:awad_nahas/features/order/presentation/screens/order_screen.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CheckOutButton extends StatefulWidget {
  const CheckOutButton({Key? key}) : super(key: key);

  @override
  State<CheckOutButton> createState() => _CheckOutButtonState();
}

class _CheckOutButtonState extends State<CheckOutButton> {
  PayFortController payFortController =  PayFortController();

  @override
  void initState() {
    payFortController.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc,OrderState>(
      listenWhen: (ctx,state)=> state is AssignOrderSuccessfullyState,
      listener: (ctx,state){
        if(state is AssignOrderSuccessfullyState){
          CartBloc.get(context).add(ModifyCartProductEvent(product: null, isAdd: false, context: context));
          RootBloc.get(context).add(const ChangeIndex(index: 0, title: ""));
          Util.pushPageAndRemoveRoutes(const RootScreen(), context);
          Util.pushPage(const OrderScreen(), context);
        }
      },
      child: BlocBuilder<OrderBloc,OrderState>(
        builder: (ctx,state){
          var orderBloc = OrderBloc.get(ctx);
          return CustomButton(
            height: 45.h,
            width: double.infinity,
            circular: 20,
            widget: state is OrderLoadingState ?
            const CircularProgressIndicator(color: Colors.white,):
            CustomText(
              text: translate("cart.place_order"),
              color: Colors.white,
              fontSize: AppStyle.average.sp,
              alignCenter: true,
            ),
            color: DMUtil.getRED(),
            onPressed: ()=> _checkOut(context,orderBloc),
          );
        },
      ),
    );
  }
  void _checkOut(BuildContext context,var orderBloc){
    payFortController.paymentWithCreditOrDebitCard(
        onSucceeded: (val){
          debugPrint("success ${val.status}");
          orderBloc.add(AddOrderEvent(list: CartBloc.get(context).cartList, totalPrice: CartBloc.get(context).totalPrice));
        },
        onFailed: (val){
          debugPrint("failed ${val.toString()}");
          SnackBarBuilder.showFeedBackMessage(context, val.toString(), DMUtil.getRED());
        },
        onCancelled: (){
          debugPrint("canceled");
        },
    );
  }
}

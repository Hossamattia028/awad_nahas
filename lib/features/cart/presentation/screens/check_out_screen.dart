import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/check_out_widgets/address.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/check_out_widgets/check_out_button.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/check_out_widgets/delivery_type.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/check_out_widgets/order_note.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/check_out_widgets/pay_with.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/check_out_widgets/payment_summary.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getBackGround(),
      appBar: GlobalAppBar(
        backGroundColor: DMUtil.getWC(),
        title: translate("cart.checkOut_title"),
        leadingIcon: const BackArrowButton(),
      ),
      bottomNavigationBar: Container(
        color: DMUtil.getWC(),
        padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: 10),
        child: const CheckOutButton(),
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            OrderAddress(),
            SizedBox(height: 10,),
            DeliveryTypeWidget(),
            SizedBox(height: 10,),
            PayWithWidget(),
            SizedBox(height: 10,),
            PaymentSummaryWidget(),
            SizedBox(height: 10,),
            OrderNoteWidget(),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

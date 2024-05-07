import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_icon.dart';
import 'package:awad_nahas/features/products/presentation/widgets/deals/buy_x_and_y_get_z.dart';
import 'package:awad_nahas/features/products/presentation/widgets/deals/buy_x_get_y.dart';
import 'package:awad_nahas/features/products/presentation/widgets/deals/single_offers.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
        backGroundColor: Colors.white,
        title: translate("app_bar.deals"),
        textColor: DMUtil.getRED(),
        icon: const CartNavIconWidget(selected: false,),
        leadingIcon: BackArrowButton(color: DMUtil.getRED(),),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: 10.w),
        child: const Column(
          children: [
            SingleOfferWidget(),
            DealsBuyXGetYWidget(),
            DealsBuyXAndYGetZWidget(),
          ],
        ),
      ),
    );
  }
}

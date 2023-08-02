import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/continue_shopping.dart';
import 'package:awad_nahas/features/order/presentation/widgets/order_tracking_widgets/order_card_details.dart';
import 'package:awad_nahas/features/order/presentation/widgets/order_tracking_widgets/tracking_line.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
        title: translate("order.track_location"),
        leadingIcon: const BackArrowButton(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OrderCardDetails(),
            const SizedBox(height: 10,),

            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppImages.orderStep1,),
                  const SmallRowDots(),
                  SvgPicture.asset(AppImages.orderStep2, ),
                  const SmallRowDots(),
                  SvgPicture.asset(AppImages.orderStep3,),
                ],
              ),
            ),

            const SizedBox(height: 10,),

            const TrackingLineWidget(),


            const SizedBox(height: 30,),
            const ContinueShoppingButton(),

          ],
        ),
      ),
    );
  }
}


class SmallRowDots extends StatelessWidget {
  const SmallRowDots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Text("------------------------------------------------------",style: TextStyle(color: DMUtil.getRED()),maxLines: 1,),
    );
  }
}


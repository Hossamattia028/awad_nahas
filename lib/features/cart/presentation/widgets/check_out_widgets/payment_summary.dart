import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/check_out_widgets/address.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/order_details.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/circle_dots.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';


class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: DMUtil.getWC(),
      shape: const RoundedRectangleBorder(
          side: BorderSide(width: 1,color: Colors.white)
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("cart.payment_summary"),
              color: DMUtil.getDC(),
              fontSize: AppStyle.average.sp,
            ),
            const SizedBox(height: 10,),
            OrderRow(title: translate("cart.sub_total") ,value: "20 ${translate("store.sar")}",),
            OrderRow(title: translate("cart.shipping_cost") ,value: "20 ${translate("store.sar")}",),
            OrderRow(title: translate("cart.tax") ,value: "20 ${translate("store.sar")}",),
            OrderRow(title: translate("cart.total_price") ,value: "220${translate("store.sar")}",isBig:true),
          ],
        ),
      ),
    );
  }
}

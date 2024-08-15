import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

class TabbySmallWidget extends StatelessWidget {
  final String amount;
  const TabbySmallWidget({super.key,required this.amount,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black26),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: translate("cart.tabby_check_out"),
            color: Colors.black,
            fontSize: AppStyle.verySmall.sp+1,
          ),
          SizedBox(
            width: 105.w,
            child: TabbyPresentationSnippet(
              price: amount,
              borderColor: Colors.white,
              currency: Currency.aed,
              lang: Util.getLang()=="ar"?Lang.ar:Lang.en,
            ),
          ),
        ],
      ),
    );
  }
}

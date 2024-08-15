import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

class TabbySmallWidget extends StatelessWidget {
  final String amount;
  const TabbySmallWidget({super.key,required this.amount,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2),
      child: TabbyPresentationSnippet(
          price: amount,
          borderColor: Colors.white,
          currency: Currency.sar,
          lang: Util.getLang()=="ar"?Lang.ar:Lang.en,
      ),
    );
  }
}

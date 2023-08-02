import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/location_card.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OrderAddress extends StatelessWidget {
  const OrderAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: DMUtil.getWC(),
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 1,color: Colors.white)
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined,color: DMUtil.getD2C(),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 220.w,
                      child: CustomText(
                        text: "Building No. 2 (Riyadh -King Faisal Dist)",
                        fontSize: AppStyle.average.sp,
                      ),
                    ),

                    const SizedBox(height: 7,),
                    SmallLineLocationData(
                      title: "${translate("profile.mobile")}: ",
                      value: "+9662123111",
                    ),
                    const SizedBox(height: 3,),
                    SmallLineLocationData(
                      title: "${translate("profile.landline_number")}: ",
                      value: "121111",
                    ),
                  ],
                ),
              ],
            ),

            InkWell(
              // onTap: () => Util.pushPage(AddNewLocationScreen(locationEntity: locationEntity,), context),
              child: CustomText(
                text: translate("button.edit"),
                color: DMUtil.getDC(),
                fontSize: AppStyle.average.sp,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

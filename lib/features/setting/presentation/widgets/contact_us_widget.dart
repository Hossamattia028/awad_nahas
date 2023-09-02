import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/setting/presentation/screens/contact_us_screen.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w),
      child: Column(
        children: [
          SmallWidget(title: translate("drawer.whats"), img: AppImages.whats,onTap: ()=> Util.sendWhatsApp("+966508443655"),),

          SmallWidget(title: translate("drawer.support"), img: AppImages.support,onTap: ()=> Util.sendMailMsg(subject: "test",msg: "message") ,),

          SmallWidget(title: translate("drawer.contact"), img: AppImages.mail,onTap: ()=> Util.pushPage(const ContactScreen(), context),),

        ],
      ),
    );
  }
}


class SmallWidget extends StatelessWidget {
  final String img;
  final String title;
  final VoidCallback onTap;
  const SmallWidget({Key? key,required this.title,required this.img,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1,color: DMUtil.getBCC())
        ),
        child: Row(
          children: [
            Image.asset(img,height: 30.w,),
            CustomText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: AppStyle.small.sp,
            ),
          ],
        ),
      ),
    );
  }
}

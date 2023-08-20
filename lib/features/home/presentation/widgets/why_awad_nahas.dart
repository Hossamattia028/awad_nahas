import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class WhyAwaNahWidget extends StatelessWidget {
  const WhyAwaNahWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: translate("store.why_awad"),
            fontSize: AppStyle.large.sp,
        ),
        const SizedBox(height: 5,),
        GridView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 4.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.h,
            mainAxisSpacing: 2.h,
            childAspectRatio: 1.1,
            mainAxisExtent: 100.h,
          ),
          itemBuilder: (BuildContext context, int index) {
            var item = list[index];
            return InkWell(
              // onTap: ()=> Util.pushPage(ProductDetailPage(item: item,), context),
                child: Column(
                  children: [
                    SvgPicture.asset(item.img,width: 50.w,),
                    SizedBox(
                      height: 40.h,
                      width: 60.w,
                      child: CustomText(
                        text: item.title,
                        fontSize: AppStyle.small.sp,
                        maxLine: 2,
                        alignCenter: true,
                      ),
                    ),
                  ],
                )
            );
          },
        ),
      ],
    );
  }
}
class Dt{
  final String title;
  final String img;
  const Dt({required this.title,required this.img});
}
List<Dt> list = const [
  Dt(title: "Deliver & Install",img: "assets/icons/Group 2219.svg"),
  Dt(title: "Official Distributor",img: "assets/icons/Group 2218.svg"),
  Dt(title: "Built-in Specialist",img: "assets/icons/Group 2218.svg"),
  Dt(title: "Product Demo",img: "assets/icons/Group 2220.svg"),
  Dt(title: "Long Product lifspan",img: "assets/icons/Group 2216.svg"),
  Dt(title: "Price Promise",img: "assets/icons/Group 2215.svg"),
] ;

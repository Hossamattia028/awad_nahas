import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_dialogs.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/like_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class RateProductsRow extends StatelessWidget {
  final ProductsEntity item;
  const RateProductsRow({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          CustomDialogs.addComment(context, item);
          // showModalBottomSheet(
          //   context: context,
          //   useRootNavigator: true,
          //   isScrollControlled: true,
          //   useSafeArea: true,
          //   backgroundColor: Colors.transparent,
          //   shape:  const RoundedRectangleBorder(
          //     borderRadius:  BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
          //   ),
          //   builder: (ctx){
          //     return AddCommentsWidget(item: item,);
          //   },
          // );
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: DMUtil.getBackGround()),
              borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LikeIcon(),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: translate("products.review_product"),
                        color: DMUtil.getDC(),
                        fontWeight: FontWeight.w600,
                        fontSize: AppStyle.average.sp-1,
                        isEllipsis: true,
                      ),
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: 220.w,
                        child: CustomText(
                          text: translate("products.help_other_to_buy"),
                          color: DMUtil.getDC().withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: AppStyle.small.sp-2,
                          isEllipsis: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              Icon(Icons.arrow_forward_ios_rounded,size: AppStyle.average.sp,),

            ],
          ),
        )
    );
  }
}

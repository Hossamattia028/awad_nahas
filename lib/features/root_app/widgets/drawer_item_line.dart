import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemLineDrawer extends StatelessWidget {
  final String title;
  final VoidCallback fn;
  final Widget? icon;
  const ItemLineDrawer({Key? key,required this.title,required this.fn,this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fn,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 15,),
              Expanded(
                child: CustomText(
                  text: title,
                  color:DMUtil.getDC(),
                  fontWeight: FontWeight.w600,
                  fontSize: AppStyle.average.sp+1,
                ),
              ),
              icon ?? Icon(Icons.arrow_forward_ios,color: DMUtil.getD2C().withOpacity(0.7),size: 15.w,),
              const SizedBox(width: 20,),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const Divider(height: 60,),
          ),


        ],
      ),
    );
  }
}
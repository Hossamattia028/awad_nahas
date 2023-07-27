import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OrderDetailsScreen extends StatelessWidget {
  final Orders data;
  const OrderDetailsScreen({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: const GlobalAppBar(
        justLogo: true,
        title: '',
        whiteLogo: true,
        backGroundColor: kPrimary,
        leadingIcon: BackArrowButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
          child: const Column(
            children:  [


            ],
          ),
        ),
      ),
    );
  }
}





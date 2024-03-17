import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/screens/order_screen.dart';
import 'package:awad_nahas/features/shared_widgets/logo_widget.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? icon;
  final Widget? leadingIcon;
  final bool justLogo;
  final bool whiteLogo;
  final Color? textColor;
  final Color backGroundColor;
  const GlobalAppBar({
    super.key,
    this.title,
    this.icon,
    this.leadingIcon,
    this.justLogo = false,
    this.whiteLogo = false,
    this.backGroundColor = Colors.transparent,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(double.infinity, AppStyle.appBarHeight.w),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: AppStyle.paddingFromTop.h),
          decoration: BoxDecoration(
            color: backGroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(justLogo)...[
                Expanded(
                  child: Stack(
                    alignment: Util.getLang()=="ar"? Alignment.centerRight:Alignment.centerLeft,
                    children: [
                      leadingIcon ?? const SizedBox.shrink(),
                      if(justLogo)LogoWidget(height: 140,width: 100,fit: BoxFit.contain,isWhite: whiteLogo,),
                    ],
                  ),
                ),
              ]else ... [
                leadingIcon ?? const SizedBox.shrink(),
                if(title!=null)Expanded(
                  child: Padding(
                    padding: leadingIcon!=null ? EdgeInsets.only(left: Util.getLang()=="ar"?40.w:0,right: Util.getLang()!="ar"?40.w:0):EdgeInsets.zero,
                    child: CustomText(
                      text: title.toString(),
                      color: textColor ?? DMUtil.getDC(),
                      fontSize: AppStyle.large.sp-1.w,
                      alignCenter: true,
                      isEllipsis: true,
                    ),
                  ),
                ),
              ],


              icon ?? const SizedBox.shrink(),
            ],
          ),
        ));
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppStyle.appBarHeight.w);
}


class BackArrowButton extends StatelessWidget {
  final VoidCallback? fn;
  final Color? color;
  final Alignment? alignment;
  const BackArrowButton({super.key,this.fn,this.alignment,this.color,});

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: fn??()=> Navigator.of(context).pop(),
        child: Padding(
          padding: EdgeInsets.only(right: 3.w, left: 3.w,top: 0),
          child: Icon(
            Icons.arrow_back_ios,
            color: color??DMUtil.getD2C(),
            size: 25.w,
          ),
        )
      ),
    );
  }
}


class OrderIcon extends StatelessWidget {
  const OrderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Util.pushPage(const OrderScreen(), context),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          const Icon(
            CupertinoIcons.bag,
            color: Colors.white,
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (ctx, state) {
              int length = OrderBloc.get(ctx).orderList.length;
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kPrimary),
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: CustomText(
                    color: Colors.white,
                    fontSize: AppStyle.verySmall.sp,
                    text: "$length",
                ),
              );
            },
          )
        ],
      ),
    );
  }
}


class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Util.pushPage(const OrderScreen(), context),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          const Icon(
            Icons.notifications_active,
            color: kPrimary,
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (ctx, state) {
              int length = OrderBloc.get(ctx).orderList.length;
              length = 1;
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kSecondPrimary),
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: CustomText(
                  color: Colors.white,
                  fontSize: AppStyle.verySmall.sp,
                  text: "$length",
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

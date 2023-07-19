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
  final String title;
  final bool onlyTitle;
  final Widget? icon;
  final Widget? leadingIcon;
  final bool justLogo;
  final bool whiteLogo;
  final Color backGroundColor;
  const GlobalAppBar({
    Key? key,
    required this.title,
    this.icon,
    this.leadingIcon,
    this.onlyTitle = false,
    this.justLogo = false,
    this.whiteLogo = false,
    this.backGroundColor = Colors.transparent
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(double.infinity, AppStyle.appBarHeight.h),
        child: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: AppStyle.paddingFromTop.h),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(18)),
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
                Expanded(
                  child: CustomText(
                    text: title,
                    color: Colors.black,
                    fontSize: AppStyle.large.sp,
                    fontWeight: FontWeight.w600,
                    alignCenter: true,
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
      Size.fromHeight(AppStyle.appBarHeight.h);
}

class GlobalWidgets {


  static Widget backArrowButton(
      VoidCallback fn, Color color, Alignment alignment) {
    return Ink(
      child: IconButton(
        onPressed: fn,
        alignment: alignment,
        padding: const EdgeInsets.only(right: 5, left: 5),
        icon: Icon(
          Icons.arrow_back,
          color: color,
          size: 23.w,
        ),
      ),
    );
  }
}

class OrderIcon extends StatelessWidget {
  const OrderIcon({Key? key}) : super(key: key);

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
  const NotificationIcon({Key? key}) : super(key: key);

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

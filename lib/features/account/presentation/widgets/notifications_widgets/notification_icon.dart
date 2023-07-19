import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/screens/notifications/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Util.pushPage(const NotificationsScreen(), context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w,vertical: 9.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w,),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10)

        ),
        child: const Icon(Icons.notifications_none,color: Colors.white,),
      ),
    );
  }
}

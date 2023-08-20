import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/setting/domain/entities/notifications_entity.dart';
import 'package:awad_nahas/features/shared_widgets/align_child_by_row.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class NotificationListCard extends StatelessWidget {
  final NotificationsEntity item;
  const NotificationListCard({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var order = getOrder(context);
    if(order==null) return const SizedBox.shrink();
    // var user = getUser(context);
    // if(user==null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: CustomText(
            text: order.statusView.toString(),
            color: Colors.black,
            fontSize: AppStyle.average.sp,
            fontFamily: primaryFontBold,
          ),
        ),
        const SizedBox(height: 10,),


        CustomText(
          text: "${translate("order.code")}: ${item.orderWpID}",
          color: Colors.black,
          fontSize: AppStyle.small.sp,
          fontFamily: primaryFontBold,
        ),

        Row(
          children: [
            CustomText(
              text: "${translate("order.date")}: ${Util.formatToDayFullMonthYear(DateTime.parse(item.date))}",
              color: Colors.black,
              fontSize: AppStyle.small.sp,
              fontFamily: primaryFontReg,
            ),
            const SizedBox(width: 20,),
            CustomText(
              text: "${translate("order.time")}: ${Util.formatTimeToHMPMorAM(DateTime.parse(item.date))}",
              color: Colors.black,
              fontSize: AppStyle.small.sp,
              fontFamily: primaryFontReg,
            ),
          ],
        ),

        CustomText(
          text: "${translate("order.customer_location")}: ${order.userCountry}  ${order.userCity} ${order.userState} ",
          color: Colors.black,
          fontSize: AppStyle.small.sp,
          fontFamily: primaryFontReg,
        ),

        CustomText(
          text: "${translate("order.customer_name")}: ${order.userName}",
          color: Colors.black,
          fontSize: AppStyle.small.sp,
          fontFamily: primaryFontReg,
        ),

        if(order.userPhone !=null && order.userPhone!="")
        CustomText(
          text: "${translate("order.customer_phone")}: ${order.userPhone}",
          color: Colors.black,
          fontSize: AppStyle.small.sp,
          fontFamily: primaryFontReg,
        ),

        if(order.userEmail !=null && order.userEmail!="")
          CustomText(
            text: "${translate("login.email")}: ${order.userEmail}",
            color: Colors.black,
            fontSize: AppStyle.small.sp,
            fontFamily: primaryFontReg,
          ),

        AlignChildRow(
          isStart: false,
          child: CustomText(
            text: "${Util.calcBetweenTwoDateTime(DateTime.parse(order.date.toString()),DateTime.now())} ${translate("order.ago")}",
            color: Colors.black,
            fontSize: AppStyle.small.sp,
            fontFamily: primaryFontReg,
          ),
        ),
        const Divider(thickness: 1,color: Colors.black,),
      ],
    );
  }


  Orders? getOrder(BuildContext context){
    // var orders = Util.getUserType()==USER_TYPE.DELIVERY_BOY.toString()?OrderBloc.get(context).driverOrdersList:OrderBloc.get(context).orderList;
    var orders = OrderBloc.get(context).orderList;
    if(orders.isEmpty)return null;
    int indexOrder = orders.indexWhere((element) => element.orderId==item.orderWpID || element.code==item.orderID);
    if(indexOrder==-1)return null;
    return orders[indexOrder];
  }

  UserService? getUser(BuildContext context){
    var users = AccountBloc.get(context).allUsers;
    int indexUser = users.indexWhere((element) => element.userId==item.userID);
    if(indexUser==-1)return null;
    return users[indexUser];
  }
}

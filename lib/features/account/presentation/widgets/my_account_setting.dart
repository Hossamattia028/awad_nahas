import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/account/presentation/screens/account_data.dart';
import 'package:awad_nahas/features/locations/presentation/screens/my_locations.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:awad_nahas/features/order/presentation/screens/order_screen.dart';
import 'package:awad_nahas/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/screens/edit_profile_screen.dart';
import 'package:awad_nahas/features/setting/presentation/widgets/small_widgets.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class MyAccountSetting extends StatelessWidget {
  const MyAccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w - 4),
          child: CustomText(
            text: translate("profile.my_account"),
            color: DMUtil.getD2C().withOpacity(0.6),
            fontWeight: FontWeight.w600,
            fontSize: AppStyle.average.sp,
          ),
        ),

        Container(
          color: DMUtil.getWC(),
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w - 4),
          child: Column(
            children: [
              SettingLineOption(title: translate("profile.orders"),onTap: ()=> Util.pushPage(const OrderScreen(), context),
                widget: Row(
                  children: [
                    BlocBuilder<OrderBloc,OrderState>(
                      builder: (ctx,state){
                        var bloc = OrderBloc.get(ctx);
                        var length = bloc.orderList.length;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if(length!=0)CircleAvatar(
                              backgroundColor: DMUtil.getPC(),
                              radius: 11.w,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: CustomText(text: "$length",fontSize: AppStyle.small.sp,color: Colors.white,),
                              ),
                            ),
                            const SizedBox(width: 10,),
                          ],
                        );
                      },
                    ),
                    Icon(Icons.arrow_forward_ios,color: DMUtil.getDC(),size: 15.w),
                  ],
                ),),
              const Divider(),
              SettingLineOption(title: translate("profile.wishlist"),onTap: ()=> Util.pushPage(const WishListScreen(), context),),
              const Divider(),
              SettingLineOption(title: translate("profile.addresses"),onTap: ()=> Util.pushPage(const MyLocationsScreen(), context),),
              const Divider(),
              SettingLineOption(title: translate("profile.profile"),onTap: ()=> Util.pushPage(const AccountDataScreen(), context),),
            ],
          ),
        )
      ],
    );
  }
}

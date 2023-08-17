import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
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
        CustomText(
          text: translate("profile.my_account"),
          color: DMUtil.getDC(),
          fontSize: AppStyle.average.sp,
        ),

        SettingLineOption(title: translate("profile.orders"),onTap: ()=> Util.pushPage(const OrderScreen(), context),
          widget: Row(
            children: [
              BlocBuilder<OrderBloc,OrderState>(
                builder: (ctx,state){
                  var bloc = OrderBloc.get(ctx);
                  var length = bloc.orderList.length;
                  return Row(
                    children: [
                      if(length!=0)CircleAvatar(
                        backgroundColor: DMUtil.getPC(),
                        radius: 9.w,
                        child: CustomText(text: "$length",fontSize: AppStyle.small.sp,color: Colors.white,),
                      ),
                      const SizedBox(width: 10,),
                    ],
                  );
                },
              ),
              Icon(Icons.arrow_forward_ios,color: DMUtil.getDC(),size: 15.w),
            ],
          ),),
        SettingLineOption(title: translate("profile.wishlist"),onTap: ()=> Util.pushPage(const WishListScreen(), context),),
        SettingLineOption(title: translate("profile.addresses"),onTap: ()=> Util.pushPage(const MyLocationsScreen(), context),),
        SettingLineOption(title: translate("profile.profile"),onTap: ()=> Util.pushPage(const EditProfilePage(), context),),
      ],
    );
  }
}

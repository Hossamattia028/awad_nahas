
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_event.dart';
import 'package:awad_nahas/features/account/presentation/widgets/notifications_widgets/notifications_list.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_icon.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: GlobalAppBar(
          justLogo: true,
          title: '',
          whiteLogo: true,
          backGroundColor: kPrimary,
          icon: DrawerIcon(ctx: context,),
        ),
        body: RefreshIndicator(
          onRefresh: () => _buildRefresh(context),
          color: kPrimary,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                CustomText(
                  text: translate("profile.notification"),
                  color: Colors.black,
                  fontSize: AppStyle.average.sp,
                  fontFamily: primaryFontBold,
                ),
                const NotificationsList(),
              ],
            ),
          ),
        )
    );
  }

  Future<void> _buildRefresh(BuildContext context) async {
    AccountBloc.get(context).add(const FetchAllNotificationsEvent());
  }
}


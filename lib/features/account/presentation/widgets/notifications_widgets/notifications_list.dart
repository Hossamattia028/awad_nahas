import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/account/presentation/widgets/notifications_widgets/notification_card.dart';
import 'package:awad_nahas/features/shared_widgets/empty_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc,AccountState>(
      builder: (ctx,state){
        var bloc = AccountBloc.get(ctx);
        if(state is FetchNotificationsLoadingState) return const Center(child: CircularProgressIndicator(color: kPrimary,),);
        if(state is! FetchNotificationsLoadingState && bloc.notificationList.isEmpty) return const EmptyDataWidget();
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
          child: ListView.separated(
            itemCount: bloc.notificationList.length,
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.sp,vertical: 5.h),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var item = bloc.notificationList[index];
              return NotificationListCard(item: item,);
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
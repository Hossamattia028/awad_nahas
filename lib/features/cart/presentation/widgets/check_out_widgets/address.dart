import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/location_card.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OrderAddress extends StatelessWidget {
  const OrderAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc,LocationsState>(
      builder: (ctx,state){
        var bloc = LocationsBloc.get(ctx);
        var list = bloc.userLocationsList;
        if(state is LocationsLoadingState)return const Center(child: CircularProgressIndicator(color: kPrimary,),);
        if(list==null)return const SizedBox.shrink();
        return Column(
          children: [
            Row(
              children: [
                CustomText(
                  text: translate("order.shipping_to"),
                  fontSize: AppStyle.average.sp,
                ),
              ],
            ),
            Card(
              elevation: 4,
              color: DMUtil.getWC(),
              shape: const RoundedRectangleBorder(
                  side: BorderSide(width: 1,color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: 10),
                    child: Column(
                      children: [
                        if(list.billingAddress!=null)LocationCardWidget(locationEntity: list.billingAddress!,currentLocation: bloc.currentCheckOutLocation==list.billingAddress,
                          isAdd: bloc.checkIFAddressEmpty(list.billingAddress!),isOrderPage: true,),
                      ],
                    ),
                  )
              ),
            ),
          ],
        );
      },
    );

  }
}

import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/presentation/screens/my_locations.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OrderAddress extends StatelessWidget {
  const OrderAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc,LocationsState>(
      builder: (ctx,state){
        var bloc = LocationsBloc.get(ctx);
        var list = bloc.userLocationsList;
        if(state is LocationsLoadingState)return const Center(child: CircularProgressIndicator(color: kPrimary,),);
        if(list==null)return const SizedBox.shrink();
        if(bloc.currentCheckOutLocation==null)return const SizedBox.shrink();
        var location  = bloc.currentCheckOutLocation;
        return InkWell(
          onTap: ()=> Util.pushPage(const MyLocationsScreen(), context),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: DMUtil.getWC(),
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 0,color: DMUtil.getD2C().withOpacity(0.5)),
                  color: DMUtil.getWC(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,color: DMUtil.getD2C().withOpacity(0.5),),
                        const SizedBox(width: 10,),
                        if(location!.address1.toString()==""&&location.address2.toString()=="")...[
                          CustomText(
                            text: translate("toast.location_mis"),
                            fontSize: AppStyle.small.sp,
                            color: DMUtil.getD2C().withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            isEllipsis: true,
                          ),
                        ]else...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 120.w,
                                child: CustomText(
                                  text: (location.city.toString()==""?location.address2:location.city),
                                  fontSize: AppStyle.small.sp,
                                  color: DMUtil.getD2C().withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                  isEllipsis: true,
                                ),
                              ),
                              SizedBox(
                                width: 240.w,
                                child: CustomText(
                                  text: "${location.address1} ${location.state}",
                                  fontSize: AppStyle.small.sp,
                                  color: DMUtil.getD2C(),
                                  isEllipsis: true,
                                ),
                              ),
                              CustomText(
                                text: location.phone,
                                fontSize: AppStyle.small.sp,
                                color: DMUtil.getD2C(),
                              ),
                            ],
                          ),
                        ],

                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,color: DMUtil.getD2C().withOpacity(0.5),size: 15.w,)
                  ],
                )
            )
          )
        );
      },
    );

  }
}

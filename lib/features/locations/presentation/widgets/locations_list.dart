import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/location_card.dart';

class LocationsList extends StatelessWidget {
  const LocationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()=> _onRefresh(context),
      color: kPrimary,
      child: BlocBuilder<LocationsBloc,LocationsState>(
        builder: (ctx,state){
          var bloc = LocationsBloc.get(ctx);
          var list = bloc.userLocationsList;
          if(state is LocationsLoadingState)return const Center(child: CircularProgressIndicator(color: kPrimary,),);
          // if(bloc.userLocationsList.isEmpty)return const LocationsEmpty();
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.w,vertical: 10),
            child: Column(
              children: [
                if(list!.shippingAddress!=null)LocationCardWidget(locationEntity: list.shippingAddress!,currentLocation: bloc.currentCheckOutLocation==list.shippingAddress,
                    isAdd: bloc.checkIFAddressEmpty(list.shippingAddress!)),
                const SizedBox(height: 20,),
                if(list.billingAddress!=null)LocationCardWidget(locationEntity: list.billingAddress!,currentLocation: bloc.currentCheckOutLocation==list.billingAddress,
                    isAdd: bloc.checkIFAddressEmpty(list.billingAddress!)),
              ],
            ),
          );
        },
      ),
    );
  }

  Future _onRefresh(BuildContext context)async{
    LocationsBloc.get(context).add(const FetchUserLocationsEvent());
  }
}

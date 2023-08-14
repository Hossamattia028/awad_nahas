
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
          return Column(
            children: [
              if(list.first.shippingAddress!=null)LocationCardWidget(locationEntity: list.first.shippingAddress!),

              if(list.first.shippingAddress!=null)LocationCardWidget(locationEntity: list.first.billingAddress!),
            ],
          );
        },
      ),
    );
  }

  Future _onRefresh(BuildContext context)async{
    LocationsBloc.get(context).add(const FetchUserLocationsEvent());
  }
}

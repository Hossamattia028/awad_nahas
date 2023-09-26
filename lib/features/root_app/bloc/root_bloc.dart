import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/setting/data/data_sources/settings_remote_data_source.dart';
import 'package:awad_nahas/features/setting/data/models/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  int currentScreenIndex = 0;
  String currentScreenTitle = translate("home.home");
  static RootBloc get(BuildContext context) => BlocProvider.of(context);
  RootBloc() : super(RootInitialState()) {
    on<ChangeIndex>((event, emit) {
      currentScreenIndex = event.index;
      currentScreenTitle = event.title;
      emit(RootSuccessState());
    });

    on<ChangeCurrentCurrency>((event, emit) {
      changeCurrentCurrency(event,emit);
    });

    on<ChangeDrawerViewEvent>((event, emit)async{
      changeDrawerView(event,emit);
    });


    on<FetchSettingEvent>((event, emit)async{
      await getAllSetting(event,emit);
    });

    on<SendMaintenanceEvent>((event, emit)async{
      await sendMaintenance(event,emit);
    });

  }


  DrawerEnum drawerEnum = DrawerEnum.MAIN;
  changeDrawerView(ChangeDrawerViewEvent event,emit){
    emit(RootLoadingState());
    drawerEnum = event.drawerEnum;
    emit(RootSuccessState());
  }

  changeCurrentCurrency(event,emit){
    emit(RootSuccessState());
  }


  getAllSetting(event,emit)async{
    emit(RootLoadingState());
    await getLocations();
    await getFaqs();
    emit(RootSuccessState());
  }

  /// our locations
  List<LocationModel> ourLocations = [];
  getLocations()async{
    try{
      ourLocations = await SettingsRemoteDataSource.getOurLocations();
    }catch(e){
      debugPrint("getLocationsRootBloc: $e");
    }
  }

  /// faqs
  List<FaqsModel> ourFaqs = [];
  getFaqs()async{
    try{
      ourFaqs = await SettingsRemoteDataSource.getOurFaqs();
    }catch(e){
      debugPrint("getFaqsRootBloc: $e");
    }
  }

  /// maintenance

  sendMaintenance(SendMaintenanceEvent event,emit)async{
    try{
      emit(MaintenanceLoadingState());
      bool check = await SettingsRemoteDataSource.sendMaintenanceRequest(event.data);
      if(check){
        emit(MaintenanceSuccessState());
      }else{
        emit(MaintenanceErrorState());
      }
    }catch(e){
      debugPrint("sendMaintenanceRootBloc: $e");
    }
  }


}

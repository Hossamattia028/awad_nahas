
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/domain/use_cases/locations_usecase.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';



class LocationsBloc extends Bloc<LocationsEvent,LocationsState>{
  /// addresses section
  FetchUserLocationsUseCase fetchUserLocationsUseCase;
  UpdateLocationUseCase  updateLocationUseCase;
  RemoveLocationUseCase  removeLocationUseCase;
  AddLocationUseCase addLocationUseCase;
  AddressEntity? userLocationsList ;
  LocationEntity? billingAddress ;
  LocationEntity? shippingAddress ;


  LocationEntity? currentCheckOutLocation;

  static LocationsBloc get(BuildContext context) => BlocProvider.of(context);


  LocationsBloc({
    required this.addLocationUseCase,
    required this.removeLocationUseCase,
    required this.updateLocationUseCase,
    required this.fetchUserLocationsUseCase}) : super(LocationsInitialState()) {

    on<UpdateCurrentLocationEvent>((event, emit) async{
      await updateCurrentCheckOutLocation(event, emit);
    });

    on<FetchUserLocationsEvent>((event, emit) async{
      await getUserLocationsData(event, emit);
    });

    on<AddLocationEvent>((event, emit) async{
      await addNewLocationsData(event, emit);
      await getUserLocationsData(event, emit);
    });

    on<UpdateLocationEvent>((event, emit) async{
      await updateLocationsData(event, emit);
      await getUserLocationsData(event, emit);
    });

    on<RemoveLocationEvent>((event, emit) async{
      await removeLocationsData(event, emit);
      await getUserLocationsData(event, emit);
    });



  }

  updateCurrentCheckOutLocation(UpdateCurrentLocationEvent event,emit){
    emit(const LocationsLoadingState());
    if(userLocationsList!.shippingAddress!=null && event.isShipping){
      currentCheckOutLocation = userLocationsList!.shippingAddress;
    }
    if(userLocationsList!.billingAddress!=null && !event.isShipping){
      currentCheckOutLocation = userLocationsList!.billingAddress;
    }
    emit(const UpdateCurrentLocationSuccessfullyState());
  }

  getUserLocationsData(event,emit)async{
    // try{
    //   if(!Util.checkUser())return;
      emit(const LocationsLoadingState());
      var res = await fetchUserLocationsUseCase();
      res.fold((l) {
        emit(const LocationsFailedState());
      },(data) {
        userLocationsList = data;
        if(userLocationsList!.billingAddress!=null)billingAddress = userLocationsList!.billingAddress;
        if(userLocationsList!.billingAddress!=null)shippingAddress = userLocationsList!.shippingAddress;
        emit(const LocationsSuccessfullyState());
      });
    // }catch(e){
    //   debugPrint("getUserLocationsData: $e");
    //   emit(const LocationsFailedState());
    // }
  }

  addNewLocationsData(event,emit)async{
    try{
      emit(const LocationsLoadingState());
      var res = await addLocationUseCase(data: event.data);
      res.fold((l) {
        emit(const LocationsFailedState());
      },(res) {
        if(res){
          emit(const LocationsSuccessfullyState());
        }else{
          emit(const LocationsFailedState());
        }
      });
    }catch(e){
      debugPrint("addNewLocationsData: $e");
      emit(const LocationsFailedState());
    }

  }

  updateLocationsData(event,emit)async{
    try{
      emit(const LocationsLoadingState());
      var res = await updateLocationUseCase(data: event.data);
      res.fold((l) {
        emit(const LocationsFailedState());
      },(res) {
        if(res){
          emit(const LocationsSuccessfullyState());
        }else{
          emit(const LocationsFailedState());
        }
      });
    }catch(e){
      debugPrint("updateLocationsData: $e");
      emit(const LocationsFailedState());
    }
  }

  removeLocationsData(event,emit)async{
    try{
      emit(const LocationsLoadingState());
      var res = await removeLocationUseCase(addressId: event.id);
      res.fold((l) {
        emit(const LocationsFailedState());
      },(res) {
        if(res){
          emit(const LocationsSuccessfullyState());
        }else{
          emit(const LocationsFailedState());
        }
      });
    }catch(e){
      debugPrint("removeLocationsData: $e");
      emit(const LocationsFailedState());
    }
  }

}
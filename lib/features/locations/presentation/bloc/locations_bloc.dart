
import 'dart:convert';

import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<LocationEntity> localUserLocationsList = [];


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


    on<AddLocalLocationEvent>((event, emit) {
       addLocalLocation(event, emit);
    });

    on<UpdateLocationEvent>((event, emit) async{
      await updateLocationsData(event, emit);
      await getUserLocationsData(event, emit);
    });

    on<RemoveLocationEvent>((event, emit) async{
      await removeLocationsData(event, emit);
      await getUserLocationsData(event, emit);
    });

    on<UpdateShippingCityEvent>((event, emit) {
      updateShippingCity(event,emit);
    });



  }

  updateCurrentCheckOutLocation(UpdateCurrentLocationEvent event,emit){
    emit(const LocationsLoadingState());
    currentCheckOutLocation = event.location;
    emit(const UpdateCurrentLocationSuccessfullyState());
  }

  getUserLocationsData(event,emit)async{
    try{
      if(!Util.checkUser())return;
      emit(const LocationsLoadingState());
      var res = await fetchUserLocationsUseCase();
      res.fold((l) {
        emit(const LocationsFailedState());
      },(data) {
        userLocationsList = data;
        if(userLocationsList!.billingAddress!=null)billingAddress = userLocationsList!.billingAddress;
        if(userLocationsList!.shippingAddress!=null)shippingAddress = userLocationsList!.shippingAddress;
        currentCheckOutLocation = null;
        localUserLocationsList = _getLocalLocations();
        emit(const LocationsSuccessfullyState());
      });
    }catch(e){
      debugPrint("getUserLocationsData: $e");
      emit(const LocationsFailedState());
    }
  }
  
  List<LocationEntity> _getLocalLocations(){
    if(!SharedPref().containPreference(Constants.allLocalLocationsList))return [];
    String data =  SharedPref().getPreferenceString(Constants.allLocalLocationsList);
    List<dynamic> decodedList = json.decode(data);
    List<LocationEntity> locationList = decodedList
        .map((location) => LocationModel.fromJsonLocal(location,"local"))
        .toList();
    return locationList;
  }
  
  addLocalLocation(AddLocalLocationEvent event,emit){
    SharedPref().removePreference(Constants.allLocalLocationsList);
    emit(const LocationsLoadingState());
    if(event.isUpdate == true){
      if(clearLocalLocation(event.data['id'])){
        localUserLocationsList.add(setLocationData(event.data,event.isUpdate == true));
      }
    }else{
      localUserLocationsList.add(setLocationData(event.data,event.isUpdate == true));
    }
    String encodedList = json.encode(localUserLocationsList
        .map((location) => LocationModel.toJsonLocal(location,"local"))
        .toList());
    SharedPref().setPreferencesString(Constants.allLocalLocationsList,encodedList);
    localUserLocationsList = _getLocalLocations();
    emit(const LocationsSuccessfullyState());
  }

  setLocationData(Map<String,dynamic> data,bool isUpdate){
    String kind = "local";
    return LocationModel(
        address1: data['${kind}_address_1'] ?? "",
        address2: data['${kind}_address_2'] ?? "",
        country: data['${kind}_country'] ?? "",
        phone: data['${kind}_phone'] ?? "",
        id: int.parse(DateTime.now().millisecond.toString()+DateTime.now().minute.toString()+DateTime.now().day.toString()),
        type: data[kind] ?? "local",
        long: 0.0,
        lat:  0.0,
        state: data['${kind}_state'] ?? "",
        firstName: data['${kind}_first_name'] ?? "",
        lastName: data['${kind}_last_name'] ?? "",
        email: data['${kind}_email'] ?? "",
        postCode: data['${kind}_postcode'] ?? "",
        locationType: data['location_type'] ?? "",
    );
  }

  bool clearLocalLocation(String locationID){
    int index = localUserLocationsList.indexWhere((element) => element.id.toString()==locationID);
    if(index!=-1){
      localUserLocationsList.removeAt(index);
      return true;
    }
    return false;
  }

  addNewLocationsData(AddLocationEvent event,emit)async{
    try{
      emit(const LocationsLoadingState());
      var res = await addLocationUseCase(data: event.data);
      updateLocationType(event.data);
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

  updateLocationsData(UpdateLocationEvent event,emit)async{
    try{
      emit(const LocationsLoadingState());
      var res = await updateLocationUseCase(data: event.data);
      updateLocationType(event.data);
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

  updateLocationType(Map<String,dynamic> data){
    if(data.toString().contains("local"))return;
    String type = data.toString().contains("shipping")?"shipping":"billing";
    SharedPref().setPreferencesString(type=="shipping"?Constants.shippingType:Constants.billingType, data[type]['location_type']);
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

  bool checkIFAddressEmpty(LocationEntity item){
    if(item.phone.isEmpty&&item.country.isEmpty&&item.phone.isEmpty){
      return true;
    }
    return false;
  }



  /// shipping list
  List<String> shippingListAr= [
    'جدة',
    'الطائف',
    'مكة',
    'بدر',
    'المدينة المنورة',
    'رابغ',
    'ينبع',
    'الرياض',
    'القصيم',
    'الرس',
    'عنيزة',
    'بريدة',
    'الخرج',
    'الزلفي',
    'العمارية',
    'البدائع',
    'رياض الخبراء',
    'الخبر',
    'الظهران',
    'الدمام',
    'القطيف',
    'الجبيل',
    'الأحساء',
    'سيهات',
    'رأس تنورة',
    'رأس الخير',
    'الهفوف',
    'الخفجي',
    'الصفوة',
    'سلوى',
    'العزيزية',
    'العوامية',
    'المبرز',
    'المجمعة',
    'جازان',
    'أبها',
    'خميس مشيط',
    'المزاحمية',
  ];
  List<String> shippingListEn= [
    'Jeddah',
    'Al-Taif',
    'Makkah',
    'Badr',
    'ALMadina Al Monawara',
    'Rabigh',
    'Yanpu',
    'Riyadh',
    'Qassim',
    'Alrass',
    'Unaizah',
    'Buraidah',
    'Al Kharj',
    'Zelfi',
    'Alammariah',
    'Al Badayea',
    'Riyadh Alkhabra',
    'AL Khobar',
    'Dhahran',
    'Dammam',
    'Qatif',
    'Jubail',
    'Hasa',
    'Saihat',
    'Ras Tanura',
    'Ras Alkher',
    'Al Hofuf',
    'Khafji',
    'AlSafwa',
    'Salwa',
    'Al-Azizia',
    'Awamiya',
    'AlMobaraz',
    'Al Majmaah',
    'Jizan ',
    'Abha',
    'Khamis Mushait',
    'Al-Muzahmiya',
  ];

  String currentShippingCity = "";
  updateShippingCity(UpdateShippingCityEvent event,emit){
    emit(const UpdateCurrentShippingLoadingState());
    if(!shippingListEn.contains(event.city.trim()) && !shippingListAr.contains(event.city.trim()))return;
    currentShippingCity = event.city;
    emit(const UpdateCurrentShippingSuccessfullyState());
  }

}
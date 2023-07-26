import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/domain/use_cases/get_all_users_usecase.dart';
import 'package:awad_nahas/features/setting/domain/entities/notifications_entity.dart';
import 'package:awad_nahas/features/setting/domain/use_cases/notifications_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/account/domain/use_cases/change_password_usercase.dart';
import 'package:awad_nahas/features/account/domain/use_cases/get_user_service_usecase.dart';
import 'package:awad_nahas/features/account/domain/use_cases/update_user_usecase.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_event.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';



class AccountBloc extends Bloc<AccountEvent,AccountState>{
  bool showPassword = false;
  UserService? currentUser;
  static AccountBloc get(BuildContext context) => BlocProvider.of(context);


  GetUserServiceUseCase getUserServiceUseCase;
  ChangePasswordUseCase changePasswordUseCase;
  UpdateUserServiceUseCase updateUserServiceUseCase;
  GetAllNotificationsUseCase getAllNotificationsUseCase;
  GetAllUsersUseCase getAllUsersUseCase;
  AccountBloc({
    required this.getUserServiceUseCase,
    required this.updateUserServiceUseCase,
    required this.changePasswordUseCase,
    required this.getAllNotificationsUseCase,
    required this.getAllUsersUseCase,
}) : super(AccountInitialState()) {

    on<UpdateProfileEvent>((event, emit) async{
      await updateProfile(event, emit);
    });

    on<FetchProfileDataEvent>((event, emit) async{
      await getProfileData(event, emit);
    });

    on<FetchAllUsersDataEvent>((event, emit) async{
      await getAllUsersData(event, emit);
    });

    on<FetchAllNotificationsEvent>((event, emit) async{
      await getAllNotifications(event, emit);
    });

    on<ChangeUserPasswordEvent>((event, emit) async{
      await changeUserPassword(event, emit);
    });

    on<ChangeNotificationModeEvent>((event, emit) {
       changeNotificationMode(event, emit);
    });
  }

  changeUserPassword(ChangeUserPasswordEvent event,emit)async{
    emit(ChangeUserPasswordState(response: AuthResponse(isLoad: true)));
    String resMsg = "";
    try{
      var res = await changePasswordUseCase(data: event.data);
      res.fold((l) {
        resMsg = l.toString();
        emit(ChangeUserPasswordState(response: AuthResponse(isFailed: true,msg: resMsg)));
      },(data) async{
        if(data.isSuccess==true){
          emit(ChangeUserPasswordState(response: AuthResponse(isSuccess: true,msg: data.msg)));
        }else{
          emit(ChangeUserPasswordState(response: AuthResponse(isFailed: true,msg: data.msg)));
        }
      });
    }catch(e){
      emit(ChangeUserPasswordState(response: AuthResponse(isFailed: true,msg: e.toString())));
      debugPrint("changeUserPassword: $e");
    }
  }

  updateProfile(UpdateProfileEvent event,emit) async{
    if(!Util.checkUser())return;
    emit(UpdateProfileState(response: AuthResponse(isLoad:  true)));
    String resMsg = "";
    try{
      var res = await updateUserServiceUseCase(userData: event.user);
      res.fold((l) {
        resMsg = l.toString();
      },(data) async{
        if(data.userId!=0){
          currentUser = data;
          emit(UpdateProfileState(response: AuthResponse(isSuccess:  true)));
          await saveUserDate(AuthResponse(user: data));
        }else{
          resMsg = translate("toast.wrong");
        }
      });
    }catch(e){
      emit(UpdateProfileState(response: AuthResponse(msg: resMsg,isFailed: true)));
      debugPrint("updateProfile: $e");
    }
  }


  getProfileData(event, emit)async{
    if(!Util.checkUser())return;
    emit(FetchProfileDataState(response: AuthResponse(isLoad: true)));
    String resMsg = "";
    try{
      var res = await getUserServiceUseCase();
      res.fold((l) {
        resMsg = l.toString();
      },(data) async{
        currentUser = data;
        emit(UpdateProfileState(response: AuthResponse(isSuccess:  true)));
        await saveUserDate(AuthResponse(user: data,isSuccess: true));
      });
    }catch(e){
      emit(FetchProfileDataState(response: AuthResponse(msg: resMsg,isFailed: true)));
      debugPrint("getProfileDataBlocError: $e");
    }
  }

  saveUserDate(AuthResponse res)async{
    if(res.user==null)return;
    await SharedPref().setPreferencesString(Constants.userId, res.user!.userId.toString());
    await SharedPref().setPreferencesString(Constants.email, res.user!.email.toString());
    await SharedPref().setPreferencesString(Constants.mobile, res.user!.phoneNumber.toString());
    await SharedPref().setPreferencesString(Constants.name, res.user!.userName.toString());
    await SharedPref().setPreferencesString(Constants.city, res.user!.cityID.toString());
  }


  /// get all users
  List<UserService> allUsers = [];
  getAllUsersData(event, emit)async{
    emit(FetchProfileDataState(response: AuthResponse(isLoad: true)));
    String resMsg = "";
    try{
      var res = await getAllUsersUseCase();
      res.fold((l) {
        resMsg = l.toString();
      },(data) async{
        if(data.isNotEmpty){
          allUsers = data;
          emit(FetchProfileDataState(response: AuthResponse(isSuccess: true)));
        }
      });
    }catch(e){
      emit(FetchProfileDataState(response: AuthResponse(msg: resMsg,isFailed: true)));
      debugPrint("getProfileDataBlocError: $e");
    }
  }



  /// notifications

  List<NotificationsEntity> notificationList = [];
  getAllNotifications(event,emit)async{
    if(!Util.checkUser())return;
    try{
      emit(const FetchNotificationsLoadingState());
      var res = await getAllNotificationsUseCase();
      res.fold((l) {
        emit(const FetchNotificationsFailedState());
      },(data) {
        notificationList = data.reversed.toList();
        emit(const FetchNotificationsSuccessfullyState());
      });
    }catch(e){
      debugPrint("getAllNotifications: $e");
      emit(const FetchNotificationsFailedState());
    }
  }

  bool isEnabledNotification = false;
  changeNotificationMode(event,emit){
    emit(AccountInitialState());
    isEnabledNotification = !isEnabledNotification;
    emit(const UpdateNotificationsModeState());
  }

}
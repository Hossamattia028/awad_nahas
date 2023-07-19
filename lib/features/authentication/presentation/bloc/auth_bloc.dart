import 'package:awad_nahas/features/authentication/data/models/user_service_model.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:awad_nahas/features/authentication/domain/use_cases/login_user_usecase.dart';
import 'package:awad_nahas/features/authentication/domain/use_cases/register_user_usecase.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_event.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_translate/flutter_translate.dart';



class AuthBloc extends Bloc<AuthEvent,AuthState>{
  bool showPassword = false;
  String resMsg = "";
  static AuthBloc get(BuildContext context) => BlocProvider.of(context);

  LoginUserServiceUseCase loginUserServiceUseCase;
  RegisterUserServiceUseCase registerUserServiceUseCase;
  AuthBloc({
    required this.loginUserServiceUseCase,
    required this.registerUserServiceUseCase,
}) : super(AuthInitialState()) {
    on<RegisterEvent>((RegisterEvent event, emit) async{
      await register(emit, event);
    });

    on<LogInEvent>((event, emit) async{
      await logIn(event,emit );
    });

    on<LogOutEvent>((event, emit) async{
      await logOut(event,emit );
    });

    on<ChangePasswordEvent>((event, emit) {
      changePasswordEvent(emit);
    });

    on<EnableAuthButtonEvent>((event, emit) {
      enableAuthButton(event,emit);
    });

    on<SendVerifyEmailEvent>((event, emit) async{
      await sendVerifyEmail(event,emit);
    });

    on<RememberMeEvent>((event, emit) {
      rememberMeFn(event,emit);
    });

    on<SetCurrentGenerateUserEvent>((event, emit){
      setCurrentGenerateUser(event, emit);
    });
  }
  bool rememberMe = false;
  rememberMeFn(event,emit){
    emit(const EnableAuthButtonLoadingState());
    rememberMe = !rememberMe;
    emit(const EnableAuthButtonState());
  }

  enableAuthButton(event,emit){
    emit(const EnableAuthButtonLoadingState());
    // enableButton = event.enable;
    emit(const EnableAuthButtonState());
  }

  register(emit,RegisterEvent event)async{
    emit(const RegisterLoadingState());
    try{
      var res = await registerUserServiceUseCase(userData: event.user);
      res.fold((l) {
        resMsg = l.toString();
      },(data) {
        resMsg = data.msg.toString();
        emit(RegisterSuccessfullyState(response: AuthResponse(msg: resMsg,isSuccess: true)));
      });
    }catch(e){
      debugPrint("registerError: $e");
      emit(RegisterFailedState(response: AuthResponse(msg: resMsg,isFailed: true)));
    }

  }

  logIn(LogInEvent event,emit)async{
    emit(const LogInLoadingState());
    // try{
      var res = await loginUserServiceUseCase(phone: event.user['phone'],password:  event.user['password']);
      res.fold((l) {
        resMsg = l.toString();
      },(data) {
        resMsg = data.msg.toString();
        if(data.user==null){
          emit(LogInFailedState(response: AuthResponse(msg: resMsg,isFailed: true)));
        }else{
          emit(LogInSuccessfullyState(response: AuthResponse(msg: resMsg,isSuccess: true)));
        }
      });
    // }catch(e){
    //   debugPrint("logInError: $e");
    //   emit(LogInFailedState(response: AuthResponse(msg: resMsg,isFailed: true)));
    // }

  }

  logOut(event,emit) async {
    emit(const LogOutLoadingState());
    await SharedPref().clearPreferences();
    emit(const LogOutState());
  }
  changePasswordEvent(emit){
    showPassword = !showPassword;
    emit(ChangePasswordState(showPass: showPassword));
  }

  sendVerifyEmail(event,emit)async{
    // var code = DateTime.now().millisecond.toString().substring(0,2).toString() + DateTime.now().minute.toString().substring(0,1)+DateTime.now().second.toString().substring(0,1)+DateTime.now().millisecondsSinceEpoch.toString().substring(0,2).toString();
    // SharedPref.preferences.setPreferencesString(Constants.lastVerificationCode,code);
    // await SendGmail.sendEmailMessage("Verification Code: $code", event.email.toString(), "awad_nahasstars Medical - Verification Code");
    // emit(ConfirmEmailState(response: AuthResponse(state: states = FetchStates.SUCCESSFULLY,msg: translate("toast.successfully_send"))));
  }

  bool verifyChangeEmailCode(String code){
    // if(code==SharedPref.preferences.getPreferenceString(Constants.lastVerificationCode).toString().trim()){
    //   return true;
    // }
    return false;
  }


  saveUserDate(AuthResponse res)async{
    if(res.user==null)return;
    await SharedPref.preferences.setPreferencesString(Constants.userId, res.user!.userId.toString());
    await SharedPref.preferences.setPreferencesString(Constants.email, res.user!.email.toString());
    await SharedPref.preferences.setPreferencesString(Constants.name, res.user!.userName.toString());
    await SharedPref.preferences.setPreferencesString(Constants.mobile, res.user!.phoneNumber.toString());
    await SharedPref.preferences.setPreferencesString(Constants.city, res.user!.countryCode.toString());
    await SharedPref.preferences.setPreferencesString(Constants.address, res.user!.address.toString());
  }


  /// this section for generate or create new account [ADMIN_SECTION]
  UserService? currentGenerateCurrentUser;
  List <String> userTypeList = [
    translate("order.delivery_boy"),
    translate("order.manager"),
    translate("order.super_admin"),
  ];
  setCurrentGenerateUser(SetCurrentGenerateUserEvent event,emit){
    emit(const UpdateGenerateUserLoadingState());
    currentGenerateCurrentUser = event.user;
    emit(const UpdateGenerateUserSuccessfullyState());
  }


  String currentCityID = "Jeddah";
  /// this city list can be assign the order on it
  List<String> citiesList = [
    "Jeddah",
    "Riyadh",
    "Elkhobar",
  ];

}
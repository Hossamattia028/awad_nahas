
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';

@immutable
abstract class AccountState{
  const AccountState();
}


class AccountInitialState extends AccountState {}



class UpdateProfileState extends AccountState{
  final AuthResponse response;
  const UpdateProfileState({required this.response});
}

class ChangeUserPasswordState extends AccountState{
  final AuthResponse response;
  const ChangeUserPasswordState({required this.response});
}

class FetchProfileDataState extends AccountState{
  final AuthResponse response;
  const FetchProfileDataState({required this.response});
}

class FetchNotificationsSuccessfullyState extends AccountState{
  const FetchNotificationsSuccessfullyState();
}

class FetchNotificationsLoadingState extends AccountState{
  const FetchNotificationsLoadingState();
}

class FetchNotificationsFailedState extends AccountState{
  const FetchNotificationsFailedState();
}




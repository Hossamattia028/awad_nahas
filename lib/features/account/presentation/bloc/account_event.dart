import 'package:flutter/material.dart';

@immutable
abstract class AccountEvent{
  const AccountEvent();
}

class UpdateProfileEvent extends AccountEvent{
  final Map<String,dynamic> user;
  const UpdateProfileEvent({required this.user});
}

class FetchProfileDataEvent extends AccountEvent{
  const FetchProfileDataEvent();
}

class FetchAllUsersDataEvent extends AccountEvent{
  const FetchAllUsersDataEvent();
}



class FetchAllNotificationsEvent extends AccountEvent{
  const FetchAllNotificationsEvent();
}




class ChangeUserPasswordEvent extends AccountEvent{
  final Map<String,dynamic> data;
  const ChangeUserPasswordEvent({required this.data});
}
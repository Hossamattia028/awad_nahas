import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';


@immutable
abstract class AuthEvent{
  const AuthEvent();
}


class LogInEvent extends AuthEvent{
  final Map<String,dynamic> user;
  const LogInEvent({required this.user});
}

class RegisterEvent extends AuthEvent{
  final Map<String,dynamic> user;
  const RegisterEvent({required this.user});
}

class ChangePasswordEvent extends AuthEvent{
  const ChangePasswordEvent();
}

class RememberMeEvent extends AuthEvent{
  const RememberMeEvent();
}

class EnableAuthButtonEvent extends AuthEvent{
  final bool enable ;
  const EnableAuthButtonEvent({required this.enable});
}

class SendVerifyEmailEvent extends AuthEvent{
  final String email;
  const SendVerifyEmailEvent({required this.email});
}

class LogOutEvent extends AuthEvent{
  const LogOutEvent();
}


class SetCurrentGenerateUserEvent extends AuthEvent{
  final UserService user;
  const SetCurrentGenerateUserEvent({required this.user});
}

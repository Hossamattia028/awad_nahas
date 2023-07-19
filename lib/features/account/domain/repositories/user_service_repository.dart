
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';

abstract class UserServiceRepository {
  Future<Either<Failure, UserService>> getUserData();
  Future<Either<Failure, List<UserService>>> getAllUsers();
  Future<Either<Failure, AuthResponse>> changePassword({required Map<String, dynamic> data});
  Future<Either<Failure, UserService>> updateUserProfile(Map<String, dynamic> userData);
}

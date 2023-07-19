import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/core/network/network.dart';
import 'package:awad_nahas/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:awad_nahas/features/authentication/domain/repositories/auth_service_repository.dart';

class AuthServiceModelRepository implements AuthServiceRepository {
  final AuthServiceRemoteDataSource userServiceRemoteDataSource;
  final NetworkInfo networkInfo;
  AuthServiceModelRepository({required this.userServiceRemoteDataSource, required this.networkInfo});


  @override
  Future<Either<Failure, AuthResponse>> loginUser(
      String phone, String password) async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await userServiceRemoteDataSource.loginUser(
            phone: phone, password: password));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> registerUser(
      Map<String, dynamic> userData,{File? storeBanner,File? storeLicense}) async {
    return Right(await userServiceRemoteDataSource.registerUser(userData,storeLicense: storeLicense,storeBanner: storeBanner));
  }





}

import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:awad_nahas/features/authentication/domain/use_cases/register_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mockito_data/test_helper.mocks.dart';




void main(){
  group('Register Auth', () {
    late RegisterUserServiceUseCase registerUserServiceUseCase;
    late MockAuthServiceRepository mockAuthServiceRepository;

    setUp(() {
      mockAuthServiceRepository = MockAuthServiceRepository();
      registerUserServiceUseCase = RegisterUserServiceUseCase(
          authServiceRepository: mockAuthServiceRepository);
    });

    var registerData = {
      "first_name":"first name",
      "last_name":"last name",
      "user_login": "502441695",
      "email":"test@gmail.com",
      "password": "otp",
    };

    test('Sign up', () async {
      AuthResponse res = AuthResponse(user: const UserService(firstName: "first name", lastName: "last name",userId: 0, userLogin: "0"), msg: "success");
      // arrange
      when(mockAuthServiceRepository.registerUser(registerData)).thenAnswer((realInvocation) async => Right(res));

      // act
      final result = await registerUserServiceUseCase(userData: registerData);

      // assert
      expect(result, isNotNull);
      expect(result, Right(res));
    });

    test('Sign up Error', () async {
      AuthResponse res = AuthResponse(user: null, msg: "success");
      // arrange
      when(mockAuthServiceRepository.registerUser(registerData)).thenAnswer((realInvocation) async => Right(res));

      // act
      final result = await registerUserServiceUseCase(userData: registerData);

      // assert
      expect(result, isNotNull);
      expect(result, Right(res));
    });
  });


}
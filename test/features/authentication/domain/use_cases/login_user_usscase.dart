import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:awad_nahas/features/authentication/domain/use_cases/login_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mockito_data/test_helper.mocks.dart';







void main(){

  group('Login Auth', () {
    late LoginUserServiceUseCase loginUserServiceUseCase;
    late MockAuthServiceRepository mockAuthServiceRepository;

    setUp(() {
      mockAuthServiceRepository = MockAuthServiceRepository();
      loginUserServiceUseCase = LoginUserServiceUseCase(
          authServiceRepository: mockAuthServiceRepository);
    });

    var loginData = {"user_login": "502441695", "password": "otp"};

    test('Sign In', () async {
      AuthResponse res = AuthResponse(user: const UserService(firstName: "first name",lastName: "last name" , userId: 0, userLogin: "0"), msg: "success");
      // arrange
      when(mockAuthServiceRepository.loginUser({"user_login": "502441695", "password": "otp"})).thenAnswer((realInvocation) async => Right(res));

      // act
      final result = await loginUserServiceUseCase(data: loginData);

      // assert
      expect(result, isNotNull);
      expect(result, Right(res));
    });

    test('Sign In Error', () async {
      AuthResponse res = AuthResponse(user: null, msg: "success");
      // arrange
      when(mockAuthServiceRepository.loginUser(loginData)).thenAnswer((realInvocation) async => Right(res));

      // act
      final result = await loginUserServiceUseCase(data: loginData);

      // assert
      expect(result, isNotNull);
      expect(result, Right(res));
    });
  });


}
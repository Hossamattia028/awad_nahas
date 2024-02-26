import 'package:awad_nahas/features/authentication/data/models/auth_response.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:awad_nahas/features/authentication/domain/use_cases/login_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_helper.mocks.dart';




void main(){
  group('Auth', () {
    late LoginUserServiceUseCase loginUserServiceUseCase;
    late MockAuthServiceRepository mockAuthServiceRepository;

    setUp(() {
      mockAuthServiceRepository = MockAuthServiceRepository();
      loginUserServiceUseCase = LoginUserServiceUseCase(
          authServiceRepository: mockAuthServiceRepository);
    });

    test('Sign In', () async {
      AuthResponse res = AuthResponse(user: const UserService(userName: "test", userId: 0, userLogin: "0"), msg: "success");
      // arrange
      when(mockAuthServiceRepository.loginUser({"user_login": "502441695", "password": "otp"})).thenAnswer((realInvocation) async => Right(res));

      // act
      final result = await loginUserServiceUseCase(data: {"user_login": "502441695", "password": "otp"});

      // assert
      expect(result, isNotNull);
      expect(result, Right(res));
    });

    test('Sign In Error', () async {
      AuthResponse res = AuthResponse(user: null, msg: "success");
      // arrange
      when(mockAuthServiceRepository.loginUser({"user_login": "502441695", "password": "otp"})).thenAnswer((realInvocation) async => Right(res));

      // act
      final result = await loginUserServiceUseCase(data: {"user_login": "502441695", "password": "otp"});

      // assert
      expect(result, isNotNull);
      expect(result, Right(res));
    });
  });


}
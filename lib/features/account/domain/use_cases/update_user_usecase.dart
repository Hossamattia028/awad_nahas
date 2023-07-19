import 'package:dartz/dartz.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:awad_nahas/features/account/domain/repositories/user_service_repository.dart';

class UpdateUserServiceUseCase {
  final UserServiceRepository userServiceRepository;

  UpdateUserServiceUseCase({
    required this.userServiceRepository,
  });

  Future<Either<Failure, UserService>> call(
      {required Map<String, dynamic> userData}) async {
    return await userServiceRepository.updateUserProfile(userData);
  }
}




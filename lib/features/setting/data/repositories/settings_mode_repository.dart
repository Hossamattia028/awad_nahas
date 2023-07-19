import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/core/network/network.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/setting/data/data_sources/settings_remote_data_source.dart';
import 'package:awad_nahas/features/setting/domain/entities/about_us.dart';
import 'package:awad_nahas/features/setting/domain/entities/notifications_entity.dart';
import 'package:awad_nahas/features/setting/domain/entities/privacy.dart';
import 'package:awad_nahas/features/setting/domain/entities/refund_policy.dart';
import 'package:awad_nahas/features/setting/domain/entities/terms.dart';
import 'package:awad_nahas/features/setting/domain/repositories/settings_repository.dart';

class SettingsModelRepository extends SettingsRepository{
  final NetworkInfo networkInfo;
  final SettingsRemoteDataSourceImpl settingsRemoteDataSourceImpl;
  SettingsModelRepository({required this.settingsRemoteDataSourceImpl,required this.networkInfo});

  @override
  Future<Either<Failure, List<AboutUs>>> getAboutUsData() async{
    // TODO: implement getAboutUsData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<NotificationsEntity>>> getAllNotifications() async{
    if (await networkInfo.isConnected()) {
      try {
        return Right(await settingsRemoteDataSourceImpl.getAllNotifications());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Privacy>>> getPrivacyData() async{
    // TODO: implement getPrivacyData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RefundPolicy>>> getRefundPolicyData() async{
    // TODO: implement getRefundPolicyData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Terms>>> getTermsData() async{
    // TODO: implement getTermsData
    throw UnimplementedError();
  }

}
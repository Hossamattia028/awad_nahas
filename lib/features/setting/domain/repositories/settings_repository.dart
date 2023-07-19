import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/setting/domain/entities/about_us.dart';
import 'package:awad_nahas/features/setting/domain/entities/notifications_entity.dart';
import 'package:awad_nahas/features/setting/domain/entities/privacy.dart';
import 'package:awad_nahas/features/setting/domain/entities/refund_policy.dart';
import 'package:awad_nahas/features/setting/domain/entities/terms.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepository{
  Future<Either<Failure, List<AboutUs>>> getAboutUsData();
  Future<Either<Failure, List<RefundPolicy>>> getRefundPolicyData();
  Future<Either<Failure, List<Terms>>> getTermsData();
  Future<Either<Failure, List<Privacy>>> getPrivacyData();


  /// user settings
  Future<Either<Failure, List<NotificationsEntity>>> getAllNotifications();
}
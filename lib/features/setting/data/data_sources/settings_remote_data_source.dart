import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/setting/data/models/about_us_model.dart';
import 'package:awad_nahas/features/setting/data/models/notifications_model.dart';
import 'package:awad_nahas/features/setting/data/models/privacy_model.dart';
import 'package:awad_nahas/features/setting/data/models/refund_policy_model.dart';
import 'package:awad_nahas/features/setting/data/models/terms_model.dart';

abstract class SettingsRemoteDataSourceImpl{
  Future<List<AboutUsModel>> getAboutUsData();
  Future<List<RefundPolicyModel>> getRefundPolicyData();
  Future<List<TermsModel>> getTermsData();
  Future<List<PrivacyModel>> getPrivacyData();


  /// user settings
  Future<List<NotificationsModel>> getAllNotifications();
}

class SettingsRemoteDataSource extends SettingsRemoteDataSourceImpl{
  final http.Client client;
  SettingsRemoteDataSource({required this.client});



  @override
  Future<List<NotificationsModel>> getAllNotifications() async {
    var response = await client.get(Uri.parse(ApiUrl.USER_NOTIFICATIONS),headers: ApiUrl.headerAuth);
    debugPrint("getAllNotifications ${response.body}");
    if (response.statusCode == 200) {
      return NotificationsModel.notificationListFromJson(jsonEncode(jsonDecode(response.body)['data']));
    } else {
      throw ServerException();
    }
  }


  @override
  Future<List<AboutUsModel>> getAboutUsData() {
    // TODO: implement getAboutUsData
    throw UnimplementedError();
  }

  @override
  Future<List<PrivacyModel>> getPrivacyData() {
    // TODO: implement getPrivacyData
    throw UnimplementedError();
  }

  @override
  Future<List<RefundPolicyModel>> getRefundPolicyData() {
    // TODO: implement getRefundPolicyData
    throw UnimplementedError();
  }

  @override
  Future<List<TermsModel>> getTermsData() {
    // TODO: implement getTermsData
    throw UnimplementedError();
  }



}
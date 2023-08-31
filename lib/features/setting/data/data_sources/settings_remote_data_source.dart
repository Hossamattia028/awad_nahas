import 'dart:convert';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
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

  static Future<List<LocationModel>> getOurLocations() async{
    var response = await http.get(Uri.parse(ApiUrl.OUR_LOCATIONS),headers: ApiUrl.headerAuth);
    debugPrint("getOurLocations ${response.body}");
    var decodedData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<LocationModel> categories =
      decodedData.map<LocationModel>((categoryModel) {

        return LocationModel(
            address1: categoryModel['title']??"",
            address2: categoryModel['address']??"",
            country: categoryModel['country']??"",
            hours: categoryModel['hours']??[],
            lat: double.parse(categoryModel['lat']??"0.0",),
            long:double.parse(categoryModel['lng']??"0.0",), phone: categoryModel['phone'], state: '', id: 0, type: '', postCode: '', lastName: '', firstName: '', email: '',
        );
      }).toList();
      return categories;
    } else {
      throw ServerException();
    }
  }



}
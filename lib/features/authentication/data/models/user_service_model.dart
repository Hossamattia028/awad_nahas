import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_translate/flutter_translate.dart';

class UserServiceModel extends UserService {
  const UserServiceModel({
    required super.userId,
    required super.userName,
    required super.email,
    required super.phoneNumber,
    // required super.image,
    super.cityID,

  });

  static UserServiceModel fromJson(Map<String, dynamic> fromJson) {
    return UserServiceModel(
      userId: fromJson['id'],
      userName: fromJson['user_nicename'] ??  '',
      email: fromJson['user_email'],
      // image: getImage(fromJson['avatar']),
      phoneNumber:fromJson['phone'] ?? '',
      // countryCode: fromJson['country_code'] ?? '',
      // cityID: fromJson['city'] ?? '',
    );
  }



  static String getImage(String? image){
    if(image==null||image==""||image=="uploads/all/")return "";
    return ApiUrl.STORAGE_URL + image;
  }
}



class Shipping {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  Shipping(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.postcode,
        this.country});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    return data;
  }
}
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';

class UserServiceModel extends UserService {
  const UserServiceModel({
    required super.userId,
    required super.userLogin,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    super.cityID,

  });

  static UserServiceModel fromJson(Map<String, dynamic> fromJson) {
    return UserServiceModel(
      userId: fromJson['ID']??Util.getUserID(),
      userLogin: fromJson['user_login'] ??  '',
      firstName: fromJson['first_name'] ??  fromJson['user_nicename'],
      lastName: fromJson['last_name'] ??  '',
      email: fromJson['user_email'],
      phoneNumber: setPhoneFromUserLogin(fromJson['user_login'])!=""? setPhoneFromUserLogin(fromJson['user_login']): ( fromJson['phone'] ?? ''),
    );
  }

  static setPhoneFromUserLogin(String userLogin){
    if(userLogin.toString()!="" &&  !userLogin.toString().contains("@") && isNumeric(userLogin.toString().trim()) == true){
      return userLogin.toString().trim();
    }
    return "";
  }

  static bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }


  static String getImage(String? image){
    if(image==null||image==""||image=="uploads/all/")return "";
    return ApiUrl.STORAGE_URL + image;
  }

  Map<String,dynamic> toJson() =>  {"ID": userId};
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
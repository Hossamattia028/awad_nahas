// ignore_for_file: constant_identifier_names

import 'package:awad_nahas/core/utils/small_fun.dart';

class ApiUrl {
  static Map<String,String> headerAuth =  {
    'Content-Type': 'application/json',
    if(Util.checkUser())'ID': Util.getUserID(),
    if(Util.checkUser())'Authorization': 'Bearer ${Util.getToken()}',
  };

  // static const String BASE_URL = 'http://10.0.2.2:8000/api/';
  static const String BASE_URL = 'https://dboy.awadnahas.com/awadnahas/api/';
  static const String STORAGE_URL = 'https://dboy.awadnahas.com/awadnahas/public/';

  //auth
  static const String REGISTER_URL = '${BASE_URL}auth/signup';
  static const String LOGIN_URL = '${BASE_URL}auth/login';

  //user data
  static const String USER_PROFILE_DATA = '${BASE_URL}profile/data';
  static const String UPDATE_USER_PROFILE = '${BASE_URL}profile/update';
  static const String UPDATE_USER_PASSWORD_PROFILE = '${BASE_URL}password/reset';
  static const String USER_NOTIFICATIONS = '${BASE_URL}user/notifications';
  static const String FETCH_ALL_USER_PROFILE = '${BASE_URL}users';


  //address
  static const String FETCH_ADDRESS = '${BASE_URL}user/address';
  static const String ADD_NEW_ADDRESS = '${BASE_URL}user/address';
  static const String UPDATE_ADDRESS = '${BASE_URL}user/address/'; //user/address/{{addressID}}
  static const String REMOVE_ADDRESS = '${BASE_URL}user/address/'; //user/address/{{addressID}}


  static const String PRODUCTS_URL = '${BASE_URL}product/';
  static const String COMMENTS_URL = '${BASE_URL}comments';
  static const String OFFERS_URL = '${BASE_URL}products/featured';
  static const String SLIDERS_URL = '${BASE_URL}banner';
  static const String CITIES_URL = '${BASE_URL}cities/';
  static const String CATEGORIES_URL = '${BASE_URL}categories';


  //cart
  static const String ADD_TO_CART = '${BASE_URL}cart';
  static const String GET_ALL_CART = '${BASE_URL}cart/';
  static const String UPDATE_CART = '${BASE_URL}cart/';

  //fav
  static const String ADD_TO_FAV= '${BASE_URL}wishlist';
  static const String GET_ALL_FAV = '${BASE_URL}wishlist/';
  static const String UPDATE_FAV = '${BASE_URL}wishlist/';
  static const String REMOVE_FAV = '${BASE_URL}wishlist/';


  static const String ADD_ORDER = '${BASE_URL}order';
  static const String FETCH_ALL_ORDERS = '${BASE_URL}order';
  static const String CANCEL_ORDER = '${BASE_URL}order';
  static const String coupon = '${BASE_URL}coupon';

}

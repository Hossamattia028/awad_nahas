// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:awad_nahas/core/utils/small_fun.dart';


// static const String BASE_URL = 'http://10.0.2.2:8000/api/';
//production
// static const String SUB_MAIN_DOMAIN = 'https://api.awadnahas.com';
// static const String SUB_MAIN_DOMAIN = 'https://awadnahas.com/awadnahas';
// static const String MAIN_DOMAIN = 'https://awadnahas.com';


class ApiUrl {
  static Map<String,String> headerAuth =  {
    'Content-Type': 'application/json',
    if(Util.checkUser())'ID': Util.getUserID(),
    // if(Util.checkUser())'Authorization': 'Bearer ${Util.getToken()}',
  };


  // //new subdomain
  // static const String SUB_MAIN_DOMAIN = 'https://abnsandbox.com/awadnahas';
  //https://test.superstore.digital/
  static const String SUB_MAIN_DOMAIN = 'https://app.abnsandbox.com';
  static const String MAIN_DOMAIN = 'https://abnsandbox.com';


  static const String CONSUMER_KEY = 'ck_5c9fbbe5e7100bf87b929ec6f5c4f2c9326f8e39';
  static const String CONSUMER_SECRET = 'cs_ec05f5345f48c8f975eff2b7d74b63a5a46ace45';

  static const String BASE_URL = '$SUB_MAIN_DOMAIN/api/';
  static const String STORAGE_URL = '$SUB_MAIN_DOMAIN/public/';

  static const String BASE_URL_ABN_PLUGIN = '$MAIN_DOMAIN/wp-json/inetwork/api/';

  //auth
  static const String REGISTER_URL = '${BASE_URL}auth/signup';
  static const String LOGIN_URL = '${BASE_URL}auth/login';
  static const String SOCIAL_AUTH_URL = '${BASE_URL}auth/social';

  //user data
  static const String USER_PROFILE_DATA = '${BASE_URL}profile/data';
  static const String UPDATE_USER_PROFILE = '${BASE_URL}profile/update';
  static const String UPDATE_USER_PASSWORD_PROFILE = '${BASE_URL}password/reset';
  static const String USER_NOTIFICATIONS = '${BASE_URL}user/notifications';
  static const String FETCH_ALL_USER_PROFILE = '${BASE_URL}users';

  static const String UPDATE_USER_TOKEN = '${BASE_URL}update_token';
  /// update token with wordpress plugin api
  static const String UPDATE_USER_TOKEN_WP_PLUGIN = '$MAIN_DOMAIN/en/wp-json/fcm/pn/subscribe';

  static const String SEND_OTP = '${BASE_URL}send-otp';


  //address
  static const String FETCH_ADDRESS = '${BASE_URL}user/addresses';
  static const String ADD_NEW_ADDRESS = '${BASE_URL}user/address';
  static const String UPDATE_ADDRESS = '${BASE_URL}user/address'; //user/address/{{addressID}}
  static const String REMOVE_ADDRESS = '${BASE_URL}user/address/'; //user/address/{{addressID}}

  static const String MODIFY_LOCAL_ADDRESS = '${BASE_URL}user/modify/local_addresses';
  static const String FETCH_ALL_LOCAL_ADDRESS = '${BASE_URL}user/local_addresses';


  static const String PRODUCTS_URL = '${BASE_URL}products';
  static const String COMMENTS_URL = '${BASE_URL}reviews';
  static const String OFFERS_URL = '${BASE_URL}products/featured';
  static const String SLIDERS_URL = '${BASE_URL}sliders/all';
  static const String CITIES_URL = '${BASE_URL}cities/';
  static const String CATEGORIES_URL = '${BASE_URL}categories/all';
  static const String BRANDS_URL = '${BASE_URL}brands/all';


  //cart
  static const String ADD_TO_CART = '${BASE_URL}cart/';
  static const String GET_ALL_CART = '${BASE_URL}cart/all/';
  static const String UPDATE_CART = '${BASE_URL}cart/';

  //fav
  static const String ADD_TO_FAV= '${BASE_URL}wishlist/';
  static const String GET_ALL_FAV = '${BASE_URL}wishlist/';
  static const String UPDATE_FAV = '${BASE_URL}wishlist/';
  static const String REMOVE_FAV = '${BASE_URL}wishlist/';


  //setting
  static String OUR_LOCATIONS = '${BASE_URL_ABN_PLUGIN}branches?lang=${Util.getLang()=="ar"?"ar":"en"}';
  static String OUR_FAQS = '${BASE_URL_ABN_PLUGIN}faq?lang=${Util.getLang()=="ar"?"ar":"en"}';
  static String CONTACT = '${BASE_URL_ABN_PLUGIN}contact_us?lang=${Util.getLang()=="ar"?"ar":"en_US"}';
  static String MAINTENANCE_IMG = '${BASE_URL_ABN_PLUGIN}maintenance_request/image';
  static String MAINTENANCE = '${BASE_URL_ABN_PLUGIN}maintenance_request?lang=${Util.getLang()=="ar"?"ar":"en_US"}';

  static const String ADD_ORDER = '${BASE_URL}orders';
  static const String FETCH_ALL_ORDERS = '${BASE_URL}orders';
  static const String CANCEL_ORDER = '${BASE_URL}orders';
  static const String UPDATE_ORDER_STATUS = '${BASE_URL}orders/update/status';//orders/update/status/{orderId}/{status}
  static const String coupon = '${BASE_URL}coupon';
  static const String TRACK_ORDER = '${BASE_URL}order_process_tracking';


  static String SERVICES = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/about-us/services-mobile-ar/":"en/about-us/services-mobile/"}';
  static String ESTRAIGIATNA = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/about-us/strategy-mobile-ar/":"en/about-us/strategy-mobile/"}';
  static String OUR_BRANDS = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/about-us/our-brands-mobile-ar/":"en/about-us/our-brands-mobile/"}';
  static String OUR_PROJECTS = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/projects-mobile-ar/":"en/projects-mobile/"}';

  static String PRIVACY = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/privacy-policy-mobile-ar/":"en/policies/privacy-policy-mobile/"}';
  static String PAYMENT_GATEWAYS = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/payment-method-mobile-ar/":"en/policies/payment-method-mobile/"}';
  static String TERMS_CONDITIONS = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/terms-and-conditions-mobile-ar/":"en/policies/terms-and-conditions-mobile/"}';
  static String REPLACEMENT = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/arexchange-return-policy-mobile-ar/":"en/policies/exchange-return-policy-mobile/"}';
  static String ENSURE = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/warranty-certificate-ar/":"en/policies/mobile/"}';
  static String DELIVERY = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/delivery-policy-mobile-ar/":"en/policies/delivery-policy-mobile/"}';


  static updateSettingUrl(){
    OUR_LOCATIONS = '${BASE_URL_ABN_PLUGIN}branches?lang=${Util.getLang()=="ar"?"ar":"en"}';
    OUR_FAQS = '${BASE_URL_ABN_PLUGIN}faq?lang=${Util.getLang()=="ar"?"ar":"en"}';
    CONTACT = '${BASE_URL_ABN_PLUGIN}contact_us?lang=${Util.getLang()=="ar"?"ar":"en_US"}';
    MAINTENANCE = '${BASE_URL_ABN_PLUGIN}maintenance_request?lang=${Util.getLang()=="ar"?"ar":"en_US"}';
    SERVICES = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/about-us/services-mobile-ar/":"en/about-us/services-mobile/"}';
    ESTRAIGIATNA = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/about-us/strategy-mobile-ar/":"en/about-us/strategy-mobile/"}';
    OUR_BRANDS = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/about-us/our-brands-mobile-ar/":"en/about-us/our-brands-mobile/"}';
    OUR_PROJECTS = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/projects-mobile-ar/":"en/projects-mobile/"}';

    PRIVACY = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/privacy-policy-mobile-ar/":"en/policies/privacy-policy-mobile/"}';
    PAYMENT_GATEWAYS = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/payment-method-mobile-ar/":"en/policies/payment-method-mobile/"}';
    TERMS_CONDITIONS = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/terms-and-conditions-mobile-ar/":"en/policies/terms-and-conditions-mobile/"}';
    REPLACEMENT = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/arexchange-return-policy-mobile-ar/":"en/policies/exchange-return-policy-mobile/"}';
    ENSURE = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/warranty-certificate-ar/":"en/policies/mobile/"}';
    DELIVERY = '$MAIN_DOMAIN/${Util.getLang()=="ar"?"ar/policies/delivery-policy-mobile-ar/":"en/policies/delivery-policy-mobile/"}';
  }
}

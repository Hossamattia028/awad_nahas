import 'dart:io';

import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/features/authentication/presentation/screens/login.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awad_nahas/core/strings/constant.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_event.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class Util{
  // implemented this function after register and login
  static getAllUserAppData({required BuildContext context,bool isSplash=false}){
    if(isSplash){
      ProductsBloc.get(context).add(const FetchAllProductsEvent());
      CategoriesBloc.get(context).add(const FetchAllCategoriesEvent());
      CategoriesBloc.get(context).add(const FetchAllBrandsEvent());
      RootBloc.get(context).add(const FetchSettingEvent());
    }
    AccountBloc.get(context).add(const FetchProfileDataEvent());
    WishlistBloc.get(context).add(const FetchAllWishlistEvent());
    CartBloc.get(context).add(const FetchAllCartEvent());
    LocationsBloc.get(context).add(const FetchUserLocationsEvent());
    // AccountBloc.get(context).add(const FetchAllNotificationsEvent());
    OrderBloc.get(context).add(const FetchAllOrderEvent());
  }


  static String? validatePhone(String value) {
    String pattern = r'^(^\+9665[5|0|3|6|4|9|1|8|7]{1}[0-9]{7})$';
    String patternEg = r'^(^\+2[0]1[0-2|5]{1}[0-9]{8})$';
    RegExp regExp = RegExp(pattern);
    if (!(regExp.hasMatch(value) || (RegExp(patternEg).hasMatch(value)))) {
      return translate("login.phone_is_wrong");
    }
    return null;
  }


  static Future<bool> verifyCode(String otp) async{
    try{
      var vC = SharedPref().getPreferenceString(Constants.lastVerificationCode);
      return vC.trim() == otp.trim();
    }catch(e){
      debugPrint("verifyFirebaseCode: $e");
      return false;
    }
  }

  /// social auth
  static GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
/*     clientId:
        '192805405686-9qe0bem69g0ph14u4coga9ibtj1v936i.apps.googleusercontent.com',*/
    serverClientId: '192805405686-7roe5iammlfnaamj588png8io80aok7f.apps.googleusercontent.com',
    scopes: <String>[
      'profile',
      'email',
    ],
  );

  static Future<String> googleSign()async{
    final GoogleSignInAccount? googleData = await GoogleSignIn(scopes: ['profile', 'email']).signIn().catchError((e){return e;});
    // GoogleSignInAccount? googleData =  await googleSignIn.signIn();
    return googleData!=null ? googleData.email : '' ;
    // final GoogleSignInAuthentication? googleAuth = await googleData?.authentication;
    // "access_token": googleAuth?.accessToken,
  }

  static Future<String> facebookLogin() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']).catchError((e){return e;});
    if(loginResult.accessToken==null)return "";
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    var data = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    if(data.user==null)return "user not found";
    String email =  data.user!.email.toString();
    if (loginResult.status == LoginStatus.success) {
      return email;
      // _accessToken = result.accessToken!;
    }else{
      return translate("toast.oops");
    }
  }

  // static Future<AccessToken?> _checkIfIsLogged() async {
  //   final accessToken = await FacebookAuth.instance.accessToken;
  //   if (accessToken != null) {
  //     return accessToken;
  //   } else {
  //     return null;
  //   }
  // }


  static Future<bool> isConnected () async{
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
    return false;
  }

  static openUrl(String url)async{
    await canLaunchUrl(Uri.parse(url))==true?
    await launchUrl(Uri.parse(url)):debugPrint("error when openGmsUrl");
  }
  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static sendMailMsg({required String subject,required String msg})async{
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'admin@awad_nahasstarsmed.com',
      query: encodeQueryParameters(<String, String>{
        subject: msg,
      }),
    );
    await canLaunchUrl(emailLaunchUri)==true?
    await launchUrl(emailLaunchUri):debugPrint("error when sendMailMsg");
  }

  static Future<String> getCurrentUserPushToken()async{
    String? token = await FirebaseMessaging.instance.getToken();
    return token??"";
  }

  static call(String phone)async{
    try{
      phone = "tel:$phone";
      await canLaunchUrl(Uri.parse(phone))==true?
      await launchUrl(Uri.parse(phone)):debugPrint("error when call");
    }catch(e){
      debugPrint("error when call: $e ");
    }
  }
  static openMapApp(String lat,String long)async{
    var url = "https://www.google.com/maps/dir/?api=1&destination=$lat,$long&travelmode=driving";
    try {
      await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("sendWhatsApp: $e");
    }
  }

  static sendWhatsApp(String phone,)async{
    var whatsappUrl = "whatsapp://send?phone=$phone&text=${Uri.encodeComponent("")}";
    try {
      await launchUrl(Uri.parse(whatsappUrl));
    } catch (e) {
      debugPrint("sendWhatsApp: $e");
    }
  }

  static bool checkUser(){
    return SharedPref.preferences.containPreference(Constants.userId);
  }

  static void changeLang({required BuildContext ctx,bool isLogin =false,required String lang}){
    // String lng = getLang()=="ar"?"en_US":"ar";
    String lng = lang;
    changeLocale(ctx,lng);
    SharedPref.preferences.setPreferencesString(Constants.userLang,lng);
    Fonts.update();
    ApiUrl.updateSettingUrl();
    RootBloc.get(ctx).add(const FetchSettingEvent());
    ProductsBloc.get(ctx).add(const UpdateAllProductsEvent());
    if(isLogin){
      Util.pushPageAndRemoveRoutes(const LoginScreen(),ctx);
    }else{
      Util.pushPageAndRemoveRoutes(const RootScreen(),ctx);
    }
  }

  static String getToken(){
    return SharedPref().getPreferenceString(Constants.token).toString().trim().replaceAll("null", "");
  }
  static String getUserID(){
    return SharedPref().getPreferenceString(Constants.userId);
  }
  static String getCity(){
    return SharedPref().getPreferenceString(Constants.city).toString().trim().replaceAll("null", "");
  }
  static String getAddress(){
    return SharedPref().getPreferenceString(Constants.address).toString().trim().replaceAll("null", "");
  }
  static String getName(){
    return SharedPref().getPreferenceString(Constants.name).toString().trim().replaceAll("null", "");
  }
  static String getEmail(){
    return SharedPref().getPreferenceString(Constants.email).toString().trim().replaceAll("null", "");
  }
  static String getMobile(){
    return SharedPref().getPreferenceString(Constants.mobile).toString().trim().replaceAll("null", "");
  }
  static String getLang(){
    return SharedPref().getPreferenceString(Constants.userLang);
  }

  static String getUserLogin(){
    return SharedPref().getPreferenceString(Constants.userLogin).toString().trim().replaceAll("null", "");
  }

  static double getLatitude(){
    return SharedPref().getPreferenceDouble(Constants.userLatitude);
  }

  static double getLongitude(){
    return SharedPref().getPreferenceDouble(Constants.userLongitude);
  }
  static double getLocationDetails(){
    return SharedPref().getPreferenceDouble(Constants.userLocationDetails);
  }

  static pushPage(Widget route, BuildContext cxt) {
    return Navigator.push(
      cxt,
      MaterialPageRoute(builder: (context) => route),
    );
  }
  static pushPageAndRemoveRoutes(Widget pushRoute, BuildContext cxt) {
    Navigator.of(cxt).pushAndRemoveUntil(MaterialPageRoute(builder:
        (BuildContext ctx) => pushRoute),(route)=>false);
  }

  /// date time helper functions
  static bool isToday(DateTime dateTime){
    if(DateTime.now().year==dateTime.year&&DateTime.now().month==dateTime.month
      &&DateTime. now().day==dateTime.day){
      return true;
    }
    return false;
  }

 // return date in this format ->  2 November 2021
  static String formatToDayFullMonthYear(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date.toLocal());
  }

  // return time in this format ->  5:30 PM
  static String formatTimeToHMPMorAM(DateTime date) {
    return DateFormat('h:mm a').format(date.toLocal());
  }


  static String calcBetweenTwoDateTime(DateTime date,DateTime anotherDate) {
    Duration diff = anotherDate.difference(date);
    if(diff.inMinutes.toDouble()>10 && diff.inHours.toDouble()<12){
      return "${diff.inHours} ${translate("order.hours")} ${diff.inDays} ${translate("order.day")}";
    }
    if(diff.inHours.toDouble()>12){
      return "${diff.inDays} ${translate("order.day")}";
    }
    return "${diff.inMinutes} ${translate("order.minute")}  ${diff.inHours} ${translate("order.hours")} ${diff.inDays} ${translate("order.day")}";
  }


  //location util
  static Future<Placemark> getAndSaveLocationDetails(LatLng latLng)async{
    try{
      List<Placemark> places = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      Placemark place = places[0];
      return place;
    }catch(e){
      debugPrint("getAndSaveLocationDetails $e");
      return Placemark();
    }
  }

  static Future<bool> checkLocationPermission() async {
    try{
      await Permission.location.request();
      // await Permission.locationAlways.request();
      // await Permission.locationWhenInUse.request();
      if (await Permission.location.serviceStatus.isEnabled)return true;
      debugPrint("checkLocationPermission ${await Permission.location.serviceStatus.isEnabled}");
      return false;
    }catch(e){
      debugPrint("checkLocationPermission $e");
      return false;
    }
  }
}

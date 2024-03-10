import 'dart:io';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/amwal/proccess.dart';
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
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:awad_nahas/features/shared_widgets/update_app.dart';
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
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
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
    AccountBloc.get(context).updateFcmToken();
    AccountBloc.get(context).add(const FetchProfileDataEvent());
    WishlistBloc.get(context).add(const FetchAllWishlistEvent());
    CartBloc.get(context).add(const FetchAllCartEvent());
    LocationsBloc.get(context).add(const FetchUserLocationsEvent());
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

  static bool validatePhoneInput(String phone,BuildContext context){
    if(phone.isNotEmpty){
      String? txt = Util.validatePhone(phone);
      if(txt!=null){
        SnackBarBuilder.showFeedBackMessage(context, txt, DMUtil.getRED());
        return false;
      }
    }
    return true;
  }


  static Future<bool> verifyCode(String otp) async{
    try{
      var vC = SharedPref().getPreferenceString(Constants.lastVerificationCode);
      // debugPrint("$vC $otp");
      return vC.trim() == otp.trim();
    }catch(e){
      debugPrint("verifyFirebaseCode: $e");
      return false;
    }
  }

  /// social auth
  static Future<String> googleSign()async{
    try{
      final GoogleSignInAccount? googleData = await GoogleSignIn(scopes: ['profile', 'email']).signIn().catchError((e){
        debugPrint("googleSign: $e");
        throw e;
      });
      // GoogleSignInAccount? googleData =  await googleSignIn.signIn();
      // final GoogleSignInAuthentication? googleAuth = await googleData?.authentication;
      // "access_token": googleAuth?.accessToken,
      return googleData!=null ? googleData.email : '' ;
    }catch(e){
      debugPrint("googleSign: $e");
      return e.toString();
    }
  }

  static Future<String> facebookLogin() async {
    try{
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']).catchError((e){
        debugPrint("googleSign: $e");
        throw e;
      });
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
    }catch(e){
      debugPrint("facebookLogin: $e");
      return e.toString();
    }
  }

  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<String> signInWithApple() async {
    try{
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      try{
        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
        );
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      }catch(e){
        debugPrint("signInWithApple $e");
        return appleCredential.email??'';
      }
      return appleCredential.email??'';
    }catch(e){
      return translate("toast.oops");
    }
  }

  static Future<bool> isConnected () async{
    try{
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
      return false;
    }catch(e){
      return false;
    }
  }

  static goToStore()async {
    if(Platform.isIOS){
      return await openUrl("https://apps.apple.com/eg/app/awad-badi-nahas/id1664429753",externalApp: true);
    }else{
      return await openUrl("https://play.google.com/store/apps/details?id=com.awadnahas.awadnahas",externalApp: true);
    }
  }

  static openUrl(String url,{bool externalApp=false})async{
    try{
      await canLaunchUrl(Uri.parse(url),)==true?
      await launchUrl(Uri.parse(url),mode: externalApp?LaunchMode.externalApplication:LaunchMode.platformDefault):debugPrint("error when openGmsUrl");
    }catch(e){
      debugPrint("openUrl: $e");
    }
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

  static calcDiscountRate({required double oldPrice,required double newPrice}){
    return ((oldPrice - newPrice) / oldPrice * 100).toStringAsFixed(2);
  }

  static bool checkUser(){
    return SharedPref.preferences.containPreference(Constants.userId);
  }

  static void changeLang({required BuildContext ctx,bool isLogin =false,required String lang,bool isUpdate = false}){
    String lng = lang;
    changeLocale(ctx,lng);
    SharedPref.preferences.setPreferencesString(Constants.userLang,lng);
    updateAppDataAfterChangeLang(ctx);
    if(isLogin){
      Util.pushPageAndRemoveRoutes(const LoginScreen(),ctx);
    }else if(isUpdate){
      Util.pushPageAndRemoveRoutes(const UpdateAppScreen(),ctx);
    }else{
      Util.pushPageAndRemoveRoutes(const RootScreen(),ctx);
    }
  }

  static updateAppDataAfterChangeLang(ctx){
    Fonts.update();
    ApiUrl.updateSettingUrl();
    RootBloc.get(ctx).add(const FetchSettingEvent());
    ProductsBloc.get(ctx).add(const UpdateAllProductsEvent());
    AmWalPlugin.initialize();
  }

  static String getToken(){
    return SharedPref().getPreferenceString(Constants.token).toString().trim().replaceAll("null", "");
  }
  static String getUserID(){
    return SharedPref().getPreferenceString(Constants.userId).replaceAll("null", "0");
  }
  static String getCity(){
    return SharedPref().getPreferenceString(Constants.city).toString().trim().replaceAll("null", "");
  }
  static String getAddress(){
    return SharedPref().getPreferenceString(Constants.address).toString().trim().replaceAll("null", "");
  }
  static String getFullName(){
    return "${getFirstName()} ${getLastName()}";
  }
  static String getFirstName(){
    return SharedPref().getPreferenceString(Constants.firstName).toString().trim().replaceAll("null", "").trim();
  }
  static String getLastName(){
    return SharedPref().getPreferenceString(Constants.lastName).toString().trim().replaceAll("null", "").trim();
  }
  static String getEmail(){
    return SharedPref().getPreferenceString(Constants.email).toString().trim().replaceAll("null", "").trim();
  }
  static String getMobile(){
    return SharedPref().getPreferenceString(Constants.mobile).toString().trim().replaceAll("null", "").trim();
  }
  static String getLang(){
    return SharedPref().getPreferenceString(Constants.userLang);
  }

  static String getUserLogin(){
    return SharedPref().getPreferenceString(Constants.userLogin).toString().trim().replaceAll("null", "").trim();
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
      List<Placemark> places = await placemarkFromCoordinates(latLng.latitude, latLng.longitude,localeIdentifier: Util.getLang()=="ar"?"ar":"en_US");
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

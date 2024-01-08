import 'dart:async';
import 'dart:io';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/utils/set_notification.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsUtils{
  static Future initialPushNotification()async{
      Permission.notification.request();
      /// for android and ios versions
      await Firebase.initializeApp();
      await SetNotification.setupFlutterNotifications();
      // Set the background messaging handler early on, as a named top-level function
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }


  static void pushNotificationListener(var productBloc,var catBloc)async{
    // if(await isHuawei()){
    //   /// just for huawei version
    //   huawei_push.Push.onMessageReceivedStream.listen(
    //     SetHuaweiNotification.onMessageReceived,
    //     onError: SetHuaweiNotification.onMessageReceiveError,
    //   );
    // }else{
      /// for android and ios versions
      FirebaseMessaging.onMessage.listen((event) {
        SetNotification.showFlutterNotification(RemoteMessage(notification: event.notification!));
        if(event.notification!=null && (event.notification!.body.toString().contains("updated") || event.notification!.body.toString().contains("Products")
            || event.notification!.body.toString().contains("التحديث") || event.notification!.body.toString().contains("المنتجات") )){
          productBloc.add(const FetchAllProductsEvent(urgentUpdate: true,page: "2000"));
          catBloc.add(const FetchMainSlidersEvent());
        }
      }).onError((err){
        debugPrint("FirebaseMessaging onMessage: $err");
      });
    }
  // }


}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await SetNotification.setupFlutterNotifications();
  /// this line customized to comment for wordpress plugin only
  if(Platform.isIOS)SetNotification.showFlutterNotification(message);

  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message ${message.messageId}');
}
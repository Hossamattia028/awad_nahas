import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/utils/set_notification.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsUtils{
  static Future initialPushNotification()async{
      await Permission.notification.request();
      /// for android and ios versions
      await Firebase.initializeApp();
      await SetNotification.setupFlutterNotifications();
      // Set the background messaging handler early on, as a named top-level function
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }


  static void pushNotificationListener(BuildContext context)async{
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
        Timer(const Duration(seconds: 2),(){
          if(event.notification!.body.toString().toLowerCase().contains("order")||event.notification!.body.toString().contains("الطلب")){
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

            // });
          }else if(event.notification!.body.toString().toLowerCase().contains("deactivated")||event.notification!.body.toString().toLowerCase().contains("activated")){

          }
        });
      });
    }
  // }


}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await SetNotification.setupFlutterNotifications();
  SetNotification.showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message ${message.messageId}');
}
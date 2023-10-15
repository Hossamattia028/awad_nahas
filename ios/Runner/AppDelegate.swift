import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseMessaging


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyCP7kyl8T11x2B8OxRJbEqIYgL47cZv7EM")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("device token is: \(deviceToken) ")
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}

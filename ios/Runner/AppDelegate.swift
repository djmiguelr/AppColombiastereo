import UIKit
import Flutter
import MediaPlayer

#if canImport(Firebase)
    import Firebase
#endif

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    #if canImport(Firebase)
      FirebaseApp.configure()
    #endif
    self.window?.insertSubview(MPVolumeView(), at: 0)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller : FlutterViewController = window?.rootViewController as! 
      FlutterViewController
      let Method_channel = "example/channel"
      let ExampleMethodChannel = FlutterMethodChannel(
      name: Method_channel,
      binaryMessenger: controller.binaryMessenger
      )
      ExampleMethodChannel.setMethodCallHandler({
          (call: FlutterMethodCall,result : @escaping FlutterResult)-> Void in
          switch call.method{
          case "getDataFromNative":
              guard let args = call.arguments as? [String: String] else {return}
              let name = args["name"]!
              result("\(name) this is from native ios")
          default:
              result(FlutterMethodNotImplemented)
          }
          
      })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

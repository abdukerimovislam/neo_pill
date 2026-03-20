import UIKit
import Flutter
import flutter_local_notifications // 🚀 НОВЫЙ ИМПОРТ

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // 🚀 МАГИЯ №1: Разрешаем показ пушей, даже если приложение сейчас открыто на экране
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    // 🚀 МАГИЯ №2: Регистрируем плагины для фонового изолята (чтобы работали кнопки Take/Skip, когда аппка убита)
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
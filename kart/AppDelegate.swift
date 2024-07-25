

import UIKit
import ApphudSDK
import OneSignalFramework
import AppMetricaCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Apphud
        Apphud.start(apiKey: "app_Ne3zAwZ9SYYzjSAPv8gUi5Fhk1CFEH")
        
        //OneSignal
        OneSignal.initialize("f93d4df3-6009-479e-9f2e-e09d0c04c9ea", withLaunchOptions: launchOptions)
        OneSignal.login(Apphud.userID())
        
        //Metrica
        let configuration = AppMetricaConfiguration(apiKey: "ca9d7e0a-2818-4ca1-9025-37e646fb34ce")
        AppMetrica.activate(with: configuration!)
        
        return true
    }
}

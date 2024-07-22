

import UIKit
import ApphudSDK
import OneSignalFramework

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Apphud
        Apphud.start(apiKey: "app_Ne3zAwZ9SYYzjSAPv8gUi5Fhk1CFEH")
        
        //OneSignal
        OneSignal.initialize("030baf23-25df-4953-a340-aeb137213f76", withLaunchOptions: launchOptions)
        OneSignal.login(Apphud.userID())
        
        return true
    }
}

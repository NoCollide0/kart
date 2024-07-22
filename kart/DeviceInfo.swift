import Foundation
import SwiftUI
import CoreTelephony



func getDeviceInfo(completion: @escaping (String) -> Void) {
    var deviceInfo = [String: Any]()
    
    deviceInfo["vivisWork"] = isConnectedToVpn()
    deviceInfo["gfdokPS"] = UIDevice.current.name
    deviceInfo["gdpsjPjg"] = UIDevice.current.model
    deviceInfo["poguaKFP"] = UIDevice.current.identifierForVendor?.uuidString
    deviceInfo["gpaMFOfa"] = getWiFiAddress()
    deviceInfo["gciOFm"] = getSimCardInfo()
    deviceInfo["bcpJFs"] = UIDevice.current.systemVersion
    deviceInfo["GOmblx"] = Locale.current.languageCode
    deviceInfo["G0pxum"] = getCurrentTimestamp()
    deviceInfo["Fpvbduwm"] = isDeviceCharging()
    deviceInfo["Fpbjcv"] = getDeviceMemory()
    deviceInfo["StwPp"] = isScreenMirrored()
    deviceInfo["KDhsd"] = isRecording()
    deviceInfo["bvoikOGjs"] = getInstalledApps()
    deviceInfo["gfpbvjsoM"] = getBatteryLevel()
    deviceInfo["gfdosnb"] = getKeyboardLanguages()
    deviceInfo["bpPjfns"] = Locale.current.regionCode
    deviceInfo["biMpaluf"] = isMetricSystem()
    deviceInfo["oahgoMAOI"] = isFullyCharged()
    
    if let jsonData = try? JSONSerialization.data(withJSONObject: deviceInfo, options: .prettyPrinted),
       let jsonString = String(data: jsonData, encoding: .utf8) {
        completion(jsonString)
    } else {
        completion("{}")
    }
}

func isConnectedToVpn() -> Bool {
    if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
       let scopes = settings["__SCOPED__"] as? [String: Any] {
        for (key, _) in scopes {
            
            if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
                return true
            }
        }
    }
    return false
}

func getWiFiAddress() -> String {
    //Пока хз как его получить
    return "192.168.1.102"
}

func getSimCardInfo() -> String {
    //Тоже хз
    return "--, --"
}

func getCurrentTimestamp() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
    return formatter.string(from: Date())
}

func isDeviceCharging() -> Bool {
    UIDevice.current.isBatteryMonitoringEnabled = true
    return UIDevice.current.batteryState == .charging
}

func getDeviceMemory() -> String {
    var memorySize: UInt64 = 0
    var size = MemoryLayout<UInt64>.size
    let result = sysctlbyname("hw.memsize", &memorySize, &size, nil, 0)
    
    if result == 0 {
        return "\(memorySize)"
    } else {
        return "Unknown"
    }
}

func isScreenMirrored() -> Bool {
    if let screens = UIScreen.screens as? [UIScreen] {
        for screen in screens {
            if screen != UIScreen.main && screen.mirrored != nil {
                return true
            }
        }
    }
    return false
}

func isRecording() -> Bool {
    return UIScreen.main.isCaptured
}

func getInstalledApps() -> [String: String] {
    //Хз
    return [:]
}

func getBatteryLevel() -> Int {
    UIDevice.current.isBatteryMonitoringEnabled = true
    return Int(UIDevice.current.batteryLevel * 100)
}

func getKeyboardLanguages() -> [String] {
    return UITextInputMode.activeInputModes.compactMap { $0.primaryLanguage }
}

func isMetricSystem() -> Bool {
    return Locale.current.usesMetricSystem
}

func isFullyCharged() -> Bool {
    UIDevice.current.isBatteryMonitoringEnabled = true
    return UIDevice.current.batteryState == .full
}

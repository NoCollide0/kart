

import SwiftUI
import AppMetricaCore

@main
struct kartApp: App {
    @AppStorage("firstEnter") private var firstEnter = true
    @State private var showLaunchScreen = true
    
    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreen()
                    .onAppear {
                        getDeviceInfo { deviceInfo in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showLaunchScreen = false
                            }
                        }
                    }
                
            } else {
                if firstEnter {
                    OnboardingView()
                } else {
                    ContentView()
                        .onAppear {
                            AppMetrica.reportEvent(name: "did_show_main_screen")
                        }
                }
                
            }
            
            
        }
    }
    
    
    
}

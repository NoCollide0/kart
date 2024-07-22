

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 24/255, green: 30/255, blue: 56/255, alpha: 1)
        UITabBar.appearance().barTintColor = UIColor(red: 24/255, green: 30/255, blue: 56/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)

    }
    
    var body: some View {
        TabView() {
            
            HomeView()
                .tabItem {
                    Image("home_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 33, height: 21)
                    Text("Home")
                        .font(.custom("SF Pro", size: 10))
                        .multilineTextAlignment(.center)
                }
            
            EmployeesView()
                .tabItem {
                    Image("employees_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 38, height: 21)
                    Text("Employees")
                        .font(.custom("SF Pro Display", size: 10))
                        .multilineTextAlignment(.center)
                }
            
            RepairView()
                .tabItem {
                    Image("repair_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 32, height: 21)
                    Text("Repair")
                        .font(.custom("SF Pro Display", size: 10))
                        .multilineTextAlignment(.center)
                }
            
            SettingsView()
                .tabItem {
                    Image("settings_icon")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 29, height: 21)
                    Text("Settings")
                        .font(.custom("SF Pro Display", size: 10))
                        .multilineTextAlignment(.center)
                }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

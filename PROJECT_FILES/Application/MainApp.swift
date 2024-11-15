import SwiftUI

@main
struct MainApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TabView {
                AppCoordinatorView(startOn: HomeRoute.start)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                AppCoordinatorView(startOn: SettingsRoute.start)
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }
        }
    }
}

import Foundation
import SwiftUI

enum SettingsRoute: AnyIdentifiable {
    case start
    case pushScreen
    case presentScreen
    case fullScreenCover

    func getView(_ coordinator: AppCoordinator) -> AnyView {
        // TODO: call another module compose
        
        switch self {
        case .start:
            AnyView(SettingsBuilder.setup(coordinator: coordinator))
        case .pushScreen:
            AnyView(SettingDetailBuilder.setup(coordinator: coordinator))
        case .presentScreen:
//            AnyView(AppCoordinatorView(startOn: SettingDetailRoute.start))
            AnyView(SettingDetailBuilder.setup(coordinator: coordinator, isShowCloseButton: true))
        case .fullScreenCover:
            AnyView(SettingDetailBuilder.setup(coordinator: coordinator, isShowCloseButton: true))
        }
    }
}

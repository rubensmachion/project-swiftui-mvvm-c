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
            return AnyView(SettingsBuilder.setup(coordinator: coordinator))
        case .pushScreen:
            return AnyView(SettingDetailBuilder.setup(coordinator: coordinator))
        case .presentScreen:
            return AnyView(SettingDetailBuilder.setup(coordinator: coordinator, isShowCloseButton: true))
        case .fullScreenCover:
            return AnyView(SettingDetailBuilder.setup(coordinator: coordinator, isShowCloseButton: true))
        }
    }
}

import Foundation
import SwiftUI

enum HomeRoute: AnyIdentifiable {
    case start
    case pushScreen
    case presentScreen
    case fullScreenCover

    func getView(_ coordinator: AppCoordinator) -> AnyView {
        // TODO: call another module compose
        
        switch self {
        case .start:
            return AnyView(HomeBuilder.setup(coordinator: coordinator))
        case .pushScreen:
            return AnyView(Text("pushScreen"))
        case .presentScreen:
            return AnyView(Text("presentScreen"))
        case .fullScreenCover:
            return AnyView(Text("fullScreenCover"))
        }
    }
}

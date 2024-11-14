import Foundation
import NetworkKit
import UIKit

final class HomeBuilder {

    static func setup(coordinator: AppCoordinator) -> HomeView {
        let network = NetworkRequest()
        let dataStore = DataStore.shared
        
        let moduleCoordinator = HomeCoordinator(appCoordinator: coordinator)
        let service = HomeService(network: network)
        let viewModel = HomeViewModel(coordinator: moduleCoordinator,
                                      service: service,
                                      dataStore: dataStore)
        let view = HomeView(viewModel: viewModel)

        return view
    }
}

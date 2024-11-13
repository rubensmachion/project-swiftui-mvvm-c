import Foundation
import NetworkKit

final class HomeBuilder {

    static func setup(coordinator: AppCoordinator) -> HomeView {
        let network = NetworkRequest()
        
        let moduleCoordinator = HomeCoordinator(appCoordinator: coordinator)
        let service = HomeService(network: network)
        let viewModel = HomeViewModel(coordinator: moduleCoordinator, service: service)
        let view = HomeView(viewModel: viewModel)

        return view
    }
}

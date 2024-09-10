import Foundation

final class HomeBuilder {

    static func setup(coordinator: AppCoordinator) -> HomeView {
        let moduleCoordinator = HomeCoordinator(appCoordinator: coordinator)
        let service = HomeService()
        let viewModel = HomeViewModel(coordinator: moduleCoordinator, service: service)
        let view = HomeView(viewModel: viewModel)

        return view
    }
}

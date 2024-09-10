import Foundation

protocol HomeCoordinatorProtocol {
    func pushSomeScreen()
    func presentSomeScreen()
    func fullScreenCover()
}

final class HomeCoordinator: HomeCoordinatorProtocol {

    // MARK: - Properties

    private let appCoordinator: any AppCoordinatorProtocol

    // MARK: - Init

    init(appCoordinator: any AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
    }

    // MARK: - Public

    func pushSomeScreen() {
        appCoordinator.push(HomeRoute.pushScreen)
    }

    func presentSomeScreen() {
        appCoordinator.presentSheet(HomeRoute.presentScreen)
    }

    func fullScreenCover() {
        appCoordinator.presentFullScreenCover(HomeRoute.fullScreenCover)
    }
}

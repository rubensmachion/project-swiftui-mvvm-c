import Foundation

protocol SettingDetailCoordinatorProtocol {
    func pushSomeScreen()
    func presentSomeScreen()
    func fullScreenCover()

    func dismiss()
}

final class SettingDetailCoordinator: SettingDetailCoordinatorProtocol {

    // MARK: - Properties

    private let appCoordinator: any AppCoordinatorProtocol

    // MARK: - Init

    init(appCoordinator: any AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
    }

    // MARK: - Public

    func pushSomeScreen() {
        appCoordinator.push(SettingDetailRoute.pushScreen)
    }

    func presentSomeScreen() {
        appCoordinator.presentSheet(SettingDetailRoute.presentScreen)
    }

    func fullScreenCover() {
        appCoordinator.presentFullScreenCover(SettingDetailRoute.fullScreenCover)
    }

    func dismiss() {
        if appCoordinator.sheet != nil {
            appCoordinator.dismissSheet()
        }
        if appCoordinator.fullScreenCover != nil {
            appCoordinator.dismissFullScreenOver()
        }
    }
}

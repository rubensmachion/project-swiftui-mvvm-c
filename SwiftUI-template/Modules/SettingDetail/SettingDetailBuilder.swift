import Foundation

final class SettingDetailBuilder {

    static func setup(coordinator: AppCoordinator,
                      isShowCloseButton: Bool = false) -> SettingDetailView {
        let moduleCoordinator = SettingDetailCoordinator(appCoordinator: coordinator)
        let service = SettingDetailService()
        let viewModel = SettingDetailViewModel(coordinator: moduleCoordinator, service: service)
        let view = SettingDetailView(viewModel: viewModel, isShowCloseButton: isShowCloseButton)

        return view
    }
}

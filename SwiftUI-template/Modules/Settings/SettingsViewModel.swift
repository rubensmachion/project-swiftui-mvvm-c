import Foundation
import SwiftUI

protocol SettingsViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }

    func selectedItem(_ item: SettingsViewModel.Item)
}

final class SettingsViewModel: SettingsViewModelProtocol {

    enum Item: String, CaseIterable {
        case item1 = "Push"
        case item2 = "Present"
        case item3 = "Cover full Screen"
    }

    // MARK: - Properties
    private let coordinator: SettingsCoordinatorProtocol
    private let service: SettingsServiceProcotol

    @Published var isLoading = false

    // MARK: - Init
    init(coordinator: SettingsCoordinatorProtocol, service: SettingsServiceProcotol) {
        self.coordinator = coordinator
        self.service = service
        isLoading = true

        service.fetch { _ in
            self.isLoading = false
        }
    }

    func selectedItem(_ item: Item) {
        switch item {
        case .item1:
            showPushView()
        case .item2:
            presentView()
        case .item3:
            coverFullScreenView()
        }
    }

    private func showPushView() {
        coordinator.pushSomeScreen()
    }

    private func presentView() {
        coordinator.presentSomeScreen()
    }

    private func coverFullScreenView() {
        coordinator.fullScreenCover()
    }
}

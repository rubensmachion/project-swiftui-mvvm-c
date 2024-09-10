import Foundation
import SwiftUI

protocol SettingDetailViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }

    func close()
}

final class SettingDetailViewModel: SettingDetailViewModelProtocol {

    // MARK: - Properties
    private let coordinator: SettingDetailCoordinatorProtocol
    private let service: SettingDetailServiceProcotol

    @Published var isLoading = false

    // MARK: - Init
    init(coordinator: SettingDetailCoordinatorProtocol, service: SettingDetailServiceProcotol) {
        self.coordinator = coordinator
        self.service = service
        isLoading = true

        service.fetch { _ in
            self.isLoading = false
        }
    }

    func close() {
        coordinator.dismiss()
    }
}

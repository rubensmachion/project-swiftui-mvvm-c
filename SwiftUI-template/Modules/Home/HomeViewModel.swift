import Foundation
import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
}

final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Properties
    private let coordinator: HomeCoordinatorProtocol
    private let service: HomeServiceProcotol

    @Published var isLoading = false

    // MARK: - Init
    init(coordinator: HomeCoordinatorProtocol, service: HomeServiceProcotol) {
        self.coordinator = coordinator
        self.service = service
        isLoading = true

        service.fetch { _ in
            self.isLoading = false
        }
    }
}

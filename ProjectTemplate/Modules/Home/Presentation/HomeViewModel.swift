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
    @Published var repositories: [String] = []

    // MARK: - Init
    init(coordinator: HomeCoordinatorProtocol, service: HomeServiceProcotol) {
        self.coordinator = coordinator
        self.service = service
        
        refresh()
    }
    
    func refresh() {
        isLoading = true

        service.fetch { result in
            switch result {
            case .success(let list):
                DispatchQueue.global().async { [weak self] in
                    let mapNames = list.compactMap { $0.name }
                    
                    DispatchQueue.main.async {
                        self?.repositories = mapNames
                        self?.isLoading = false
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

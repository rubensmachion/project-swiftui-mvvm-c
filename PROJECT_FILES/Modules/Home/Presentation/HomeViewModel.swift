import Foundation
import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
}

final class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Properties
    
    private let coordinator: HomeCoordinatorProtocol
    private let service: HomeServiceProcotol
    private let dataStore: IDataStore

    @Published var isLoading = false
    @Published var repositories: [String] = []

    // MARK: - Init
    
    init(coordinator: HomeCoordinatorProtocol,
         service: HomeServiceProcotol,
         dataStore: IDataStore) {
        self.coordinator = coordinator
        self.service = service
        self.dataStore = dataStore
        
        refresh()
    }
    
    func refresh() {
        isLoading = true
        showData()

        service.fetch { [weak self] result in
            switch result {
            case .success(let list):
                self?.processList(list)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func processList(_ list: [UserRepositoryResponse]) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let context = dataStore.backgroundContext
            do {
                for item in list {
                    let repo = try ReposModel.create(dataStore: dataStore,
                                                     context: context)
                    repo.name = item.name
                }
                
                try self.dataStore.save(context: context)
                
                self.showData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func showData() {
        Task {
            let fetch = try await ReposModel.fetch(dataStore: self.dataStore)
            
            let items = fetch?.compactMap { $0.name }
            
            DispatchQueue.main.async { [weak self] in
                self?.repositories = items ?? []
                self?.isLoading = false
            }
        }
    }
}

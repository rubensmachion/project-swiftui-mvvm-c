import Foundation
import NetworkKit

protocol HomeServiceProcotol {
    func fetch(completion: @escaping (HomeServiceResult<[UserRepositoryResponse]>) -> Void)
}

enum HomeServiceResult<T> where T: Decodable {
    case success(T)
    case failure(Error)
}

enum HomeServiceEndpoint {
    case getRepos
    
    var config: IRequestConfig {
        switch self {
        case .getRepos:
            return getRepos()
        }
    }
    
    private func getRepos() -> IRequestConfig {
        return RequestConfig(path: "/users/rubensmachion/repos")
    }
}

final class HomeService: HomeServiceProcotol {

    private let network: INetworkRequest
    
    init(network: INetworkRequest) {
        self.network = network
    }
    
    func fetch(completion: @escaping (HomeServiceResult<[UserRepositoryResponse]>) -> Void) {
        let endpoint = HomeServiceEndpoint.getRepos
        
        network.request(with: endpoint.config,
                        type: [UserRepositoryResponse].self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

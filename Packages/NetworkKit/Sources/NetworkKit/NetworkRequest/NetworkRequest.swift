import Foundation

public enum RequestResult {
    case success(Data)
    case failure(RequestError)
}

public enum RequestResultDecodable<T> where T: Decodable {
    case success(T)
    case failure(RequestError)
}

public enum RequestError: Error {
    case invalidData
    case invalidRequest
    case decodeFailed
    case error(error: Error)
    case error(message: String)
}

public protocol INetworkRequest {
    func request(with config: IRequestConfig, completion: @escaping (RequestResult) -> Void)
    func request<T>(with config: IRequestConfig, type: T.Type, completion: @escaping (RequestResultDecodable<T>) -> Void) where T: Decodable
}

public final class NetworkRequest: INetworkRequest {
    
    private let session: URLSession

    public init(configuration: URLSessionConfiguration = .default) {
        configuration.protocolClasses?.insert(PrintProtocol.self, at: 0)
        self.session = .init(configuration: configuration, delegate: nil, delegateQueue: nil)
    }

    public func request(with config: IRequestConfig, completion: @escaping (RequestResult) -> Void) {
        guard let urlRequest = config.createURLRequest() else {
            completion(.failure(.invalidRequest))
            return
        }

        let task = session.dataTask(with: urlRequest) { data, urlResponse, error in

            if config.debugMode {
                PrintProtocol.printDebugData(scope: "Response", url: urlRequest.url?.absoluteString, data: data)
            }

            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }
    
    public func request<T>(with config: IRequestConfig,
                           type: T.Type,
                           completion: @escaping (RequestResultDecodable<T>) -> Void) where T: Decodable {
        request(with: config) { [weak self] result in
            switch result {
            case .success(let data):
                guard !data.isEmpty else {
                    completion(.failure(.invalidData))
                    return
                }
                
                let decodedResult = self?.defaultMapper(data: data, to: type, isDebugEnable: config.debugMode)
                
                guard let decodedResult = decodedResult else {
                    completion(.failure(.decodeFailed))
                    return
                }
                
                completion(.success(decodedResult))
                
            case .failure(let error):
                completion(.failure(.error(error: error)))
            }
        }
    }
    
    private func defaultMapper<T>(data: Data, to type: T.Type, isDebugEnable: Bool) -> T? where T: Decodable {
        do {
            let result = try JSONDecoder().decode(type, from: data)

            return result
        } catch {
            if isDebugEnable {
                print(error.localizedDescription)
            }
            return nil
        }
    }
}

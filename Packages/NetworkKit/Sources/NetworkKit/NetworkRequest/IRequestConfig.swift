import Foundation

public struct Constants {
    public static var host: String = "api-dev.callspam.org"
}

public enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}

public enum ParameterEncoding {
    case body
    case url
    case urlOnBody
    case listOnBody(paramList: [Any]) // When used parameters: [String: Any] will ignored
}

public protocol IRequestConfig {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get set }
    var headers: [String: String] { get }
    var parametersEncoding: ParameterEncoding { get }
    var debugMode: Bool { get }
    
    func createURLRequest() -> URLRequest?
}

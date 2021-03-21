import Foundation
import Alamofire

protocol ApiRequestable: URLRequestConvertible {
    var host: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var params: Parameters? { get }
    var shouldAddAuthHeader: Bool { get }
    
    func asURLRequest() throws -> URLRequest
}

extension ApiRequestable {
    var host: String {
        return ApiConstants.Url.apiHost
    }
    
    var headers: [String: String] {
        var headers = [String: String]()
        if let token = token, shouldAddAuthHeader {
            headers["Authorization"] = token
        }
        
        return headers
    }
    
    var shouldAddAuthHeader: Bool {
        return true
    }
    
    var token: String? {
        KeychainManager.shared.getToken()
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: host + path) else {
            throw CustomError.runtimeError("Failed to create url")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        urlRequest.timeoutInterval = ApiConstants.defaultRequestTimeout
        
        if method == .get {
            return try URLEncoding.queryString.encode(urlRequest, with: params)
        } else {
            return try JSONEncoding.default.encode(urlRequest, with: params)
        }
    }
}

enum CustomError: Error {
    case runtimeError(String)
}

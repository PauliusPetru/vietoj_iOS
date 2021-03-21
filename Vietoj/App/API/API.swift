import Foundation
import Alamofire

struct API {
    enum Result {
        case success(Data)
        case error(ApiError)
    }

    static func sendRequest(request: ApiRequestable, completionHandler: @escaping (Result) -> ()) {
        
        AF.request(request).validate().responseData { responseData in
            switch responseData.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                var errorToUse = ApiError(success: false, error: error.localizedDescription)
                if let data = responseData.data,
                    let apiError: ApiError = JSONCodable.decode(fromData: data) {
                    errorToUse = apiError
                }
                
                if responseData.response?.statusCode == ApiConstants.ResponseStatusCode.unauthorized {
                    UIManager.goToAuth()
                } else {
                    completionHandler(.error(errorToUse))
                }
            }
        }
    }
}

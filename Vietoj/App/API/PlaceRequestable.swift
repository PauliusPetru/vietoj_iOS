import Foundation
import Alamofire

struct PlaceRequestable: ApiRequestable {
    var method = HTTPMethod.get
    var path: String
    var shouldAddAuthHeader = false
    var params: Parameters?

    init(code: String) {
        path = ApiConstants.Url.place + "/\(code)"
    }
}

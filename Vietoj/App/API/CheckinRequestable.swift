import Foundation
import Alamofire

struct CheckinRequestable: ApiRequestable {
    var method = HTTPMethod.post
    var path = ApiConstants.Url.chechin
    var shouldAddAuthHeader = true
    var params: Parameters?

    init(place id: Int, and name: String) {
        params = ["pid": "\(id)",
                  "name": name]
    }
}

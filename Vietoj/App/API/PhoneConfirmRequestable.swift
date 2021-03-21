import Foundation
import Alamofire

struct PhoneConfirmRequestable: ApiRequestable {
    var method = HTTPMethod.post
    var path = ApiConstants.Url.Auth.phoneConfirm
    var shouldAddAuthHeader = false
    var params: Parameters?

    init(with code: String) {
        params = ["confirmation_code": code]
    }
}

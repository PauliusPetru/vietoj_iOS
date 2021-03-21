import Foundation
import Alamofire

struct PhoneConfirmRequestable: ApiRequestable {
    var method = HTTPMethod.post
    var path: String
    var shouldAddAuthHeader = false
    var params: Parameters?

    init(with code: String, registrationId: Int) {
        path = ApiConstants.Url.Auth.phoneConfirm + "\(registrationId)/confirm"
        params = ["confirmation_code": code]
    }
}

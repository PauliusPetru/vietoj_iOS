import Foundation
import Alamofire

struct RegistrationRequestable: ApiRequestable {
    var method = HTTPMethod.post
    var path = ApiConstants.Url.Auth.registration
    var shouldAddAuthHeader = false
    var params: Parameters?

    init(with phone: String) {
        params = ["phone": phone]
    }
}

import Foundation

final class RegistrationVM: NSObject {
    func submitRegistration(with name: String,
                            and phone: String,
                            completion: @escaping ((RegistrationSuccessModel?, ApiError?) -> ())) {
        let request = RegistrationRequestable(with: phone)
        API.sendRequest(request: request) { result in
            switch result {
            case .success(let data):
                KeychainManager.shared.set(name: name)
                asyncOnMain {
                    completion(JSONCodable.decode(fromData: data), nil)
                }
            case .error(let error):
                asyncOnMain {
                    completion(nil, error)
                }
            }
        }
    }
}

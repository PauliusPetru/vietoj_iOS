import Foundation

final class NumberConfirmVM: NSObject {
    
    func confirm(_ code: String,
                 completion: @escaping ((PhoneConfirmSuccessModel?, ApiError?) -> ())) {
        let request = PhoneConfirmRequestable(with: code)
        API.sendRequest(request: request) { result in
            switch result {
            case .success(let data):
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

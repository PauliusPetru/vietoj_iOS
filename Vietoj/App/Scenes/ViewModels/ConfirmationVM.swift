import Foundation

final class ConfirmationVM: NSObject {
    func checkin(place id: Int,
                 completion: @escaping ((_ isSucces: Bool, ApiError?) -> ())) {
        let request = CheckinRequestable(place: id,
                                         and: KeychainManager.shared.getName() ?? "")
        
        API.sendRequest(request: request) { result in
            switch result {
            case .success:
                asyncOnMain {
                    completion(true, nil)
                }
            case .error(let error):
                asyncOnMain {
                    completion(false, error)
                }
            }
        }
    }
}

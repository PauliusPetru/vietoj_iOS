import Foundation

final class ScannerVM: NSObject {
    func fetchInfo(for code: String, completion: @escaping ((PlaceModel?, ApiError?) -> ())) {
        let request = PlaceRequestable(for: code)
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

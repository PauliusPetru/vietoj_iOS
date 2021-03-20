import Foundation

final class RegistrationVM: NSObject {
    
    //TODO: API call
    func register(with name: String, and phone: String, completion: @escaping (() -> ())) {
        
        asyncOnMain {
            completion()
        }
    }
}

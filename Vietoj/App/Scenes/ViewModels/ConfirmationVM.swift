import Foundation

final class ConfirmationVM: NSObject {
    
    //TODO: API call and return model
    func submitRegistration(completion: @escaping (() -> ())) {
        
        asyncOnMain {
            completion()
        }
    }
}

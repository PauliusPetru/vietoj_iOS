import Foundation

final class NumberConfirmVM: NSObject {
    
    func confirm(_ code: String, completion: @escaping (() -> ())) {
        
        asyncOnMain {
            completion()
        }
    }
}

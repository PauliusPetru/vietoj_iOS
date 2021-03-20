import UIKit

final class RegistrationVC: UIViewController {
    
    private var registrationVM: RegistrationVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registrationVM = RegistrationVM()
    }
}

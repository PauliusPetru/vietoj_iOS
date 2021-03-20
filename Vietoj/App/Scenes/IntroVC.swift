import UIKit

final class IntroVC: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupUI
    }
    
    @IBAction private func registerButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "RegistrationVC", sender: nil)
    }
}

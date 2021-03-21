import UIKit

final class IntroVC: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction private func registerButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "RegistrationVC", sender: nil)
    }
    
    private func setupUI() {
        titleLabel.text = __("intro_screen_title")
        descriptionLabel.text = __("intro_screen_description")
        registerButton.setTitle(__("intro_screen_submit_button"), for: .normal)
    }
}

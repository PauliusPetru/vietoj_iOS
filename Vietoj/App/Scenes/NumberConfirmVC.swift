import UIKit

final class NumberConfirmVC: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var numberTitleLabel: UILabel!
    @IBOutlet private weak var codeTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    
    private var numberConfirmVM: NumberConfirmVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap()
        numberConfirmVM = NumberConfirmVM()
    }
    
    @IBAction private func submitAction(_ sender: Any) {
        UIManager.goToMainScreen()
    }
}

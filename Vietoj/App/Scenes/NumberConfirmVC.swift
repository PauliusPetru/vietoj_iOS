import UIKit

final class NumberConfirmVC: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var numberTitleLabel: UILabel!
    @IBOutlet private weak var codeTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    
    private var numberConfirmVM: NumberConfirmVM?
    
    private var fieldPossibleAutofillReplacementAt: Date?
    private var fieldPossibleAutofillReplacementRange: NSRange?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap()
        numberConfirmVM = NumberConfirmVM()
        setupUI()
    }
    
    @IBAction private func submitAction(_ sender: Any) {
        UIManager.goToMainScreen()
    }
    
    private func setupUI() {
        titleLabel.text = __("phone_screen_title")
        numberTitleLabel.text = __("phone_screen_phone_title")
        codeTextField.placeholder = __("phone_screen_phone_placeholder")
        submitButton.setTitle(__("phone_screen_submit_button"), for: .normal)
    }
}

extension NumberConfirmVC: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string == " " || string == "" {
            self.fieldPossibleAutofillReplacementRange = range
            self.fieldPossibleAutofillReplacementAt = Date()
        } else {
            if fieldPossibleAutofillReplacementRange == range,
               let replacedAt = self.fieldPossibleAutofillReplacementAt,
               Date().timeIntervalSince(replacedAt) < 0.1 {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    textField.resignFirstResponder()
                    self.submitAction(self)
                }
            }
            self.fieldPossibleAutofillReplacementRange = nil
            self.fieldPossibleAutofillReplacementAt = nil
        }

        return true
    }
}

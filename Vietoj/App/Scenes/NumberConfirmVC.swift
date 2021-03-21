import UIKit

final class NumberConfirmVC: ViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var numberTitleLabel: UILabel!
    @IBOutlet private weak var codeTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    
    private var numberConfirmVM: NumberConfirmVM?
    
    private var fieldPossibleAutofillReplacementAt: Date?
    private var fieldPossibleAutofillReplacementRange: NSRange?
    
    var registrationId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap()
        numberConfirmVM = NumberConfirmVM()
        setupUI()
    }
    
    @IBAction private func submitAction(_ sender: Any) {
        guard let code = codeTextField.text, let registrationId = registrationId else {
            showAllert(title: "Check field", message: "Check code text")
            return
        }
        
        numberConfirmVM?.confirm(code, registrationId: registrationId) { [weak self] model, error in
            if let phoneConfirmModel = model {
                KeychainManager.shared.set(token: phoneConfirmModel.token)
                UIManager.goToMainScreen()
            } else {
                self?.showAllert(title: "Something wrong", message: error?.error ?? "")
            }
        }
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

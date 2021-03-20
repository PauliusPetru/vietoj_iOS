import UIKit

final class RegistrationVC: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var phoneLabelTitle: UILabel!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var privacyTextField: UITextView!
    @IBOutlet private weak var submitButton: UIButton!
    
    private var registrationVM: RegistrationVM?
    
    private var fieldPossibleAutofillReplacementAt: Date?
    private var fieldPossibleAutofillReplacementRange: NSRange?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardOnTap()
        registrationVM = RegistrationVM()
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    @IBAction private func submitAction(_ sender: Any) {
        performSegue(withIdentifier: "NumberConfirmVC", sender: nil)
    }
    
    func gotoNextField(from field: UITextField) {
        if field == nameTextField {
            phoneTextField.becomeFirstResponder()
        } else {
            field.resignFirstResponder()
        }
    }
}

extension RegistrationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        gotoNextField(from: textField)
        return false
    }
    
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
                    self?.gotoNextField(from: textField)
                }
            }
            self.fieldPossibleAutofillReplacementRange = nil
            self.fieldPossibleAutofillReplacementAt = nil
        }

        return true
    }
}

import UIKit

final class RegistrationVC: ViewController {
    
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
        setupUI()
        nameTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    func gotoNextField(from field: UITextField) {
        if field == nameTextField {
            phoneTextField.becomeFirstResponder()
        } else {
            field.resignFirstResponder()
        }
    }
    
    @IBAction private func submitAction(_ sender: Any) {
        guard let name = nameTextField.text,
              !name.isEmpty,
              let phone = phoneTextField.text,
              !phone.isEmpty else {
            showAllert(title: "Check fields", message: "Check name and phone")
            return
        }
        
        registrationVM?.submitRegistration(with: name, and: phone) { [weak self] model, error in
            if let registrationModel = model {
                self?.performSegue(withIdentifier: "NumberConfirmVC", sender: registrationModel.id)
            } else {
                self?.showAllert(title: "Something wrong", message: error?.error ?? "")
            }
        }
    }
    
    private func setupUI() {
        titleLabel.text = __("intro_screen_title")
        nameTitleLabel.text = __("intro_screen_name_title")
        nameTextField.placeholder = __("intro_screen_name_placeholder")
        phoneLabelTitle.text = __("intro_screen_phone_title")
        phoneTextField.placeholder = __("intro_screen_phone_placeholder")
        privacyTextField.addHyperLinksToText(originalText: __("intro_screen_privacy_description"),
                                             hyperLinks: [__("intro_screen_privacy_title"): "privacy_url"])
        submitButton.setTitle(__("intro_screen_submit_button"),
                              for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let numberConfirmVC = (segue.destination as? NumberConfirmVC) {
            numberConfirmVC.registrationId = sender as? Int
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

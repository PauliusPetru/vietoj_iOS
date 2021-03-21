import UIKit

final class ConfirmationVC: ViewController {
    
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var statusStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var adressLabel: UILabel!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var subStatusLabel: UILabel!
    
    private var confirmationVM: ConfirmationVM?
    
    var onDissmis: (() -> ())?
    var placeModel: PlaceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmationVM = ConfirmationVM()
        setupUI()
        
        submitButton.setTitle(__("confirmation_screen_submit_button"), for: .normal)
    }
    
    @objc
    private func dismiss(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: onDissmis)
    }
    
    private func setupUI() {
        guard let placeModel = placeModel else {
            dismiss(animated: false, completion: onDissmis)
            return
        }
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector (self.dismiss (_:)))
        backgroundView.addGestureRecognizer(gestureRecognizer)
        statusStackView.isHidden = true
        submitButton.setTitle(__("confirmation_screen_submit_button"), for: .normal)
        titleLabel.text = placeModel.name
        adressLabel.text = placeModel.address
        
    }
    
    @IBAction private func submitAction(_ sender: Any) {
        guard let placeId = placeModel?.id else {
            dismiss(animated: true, completion: onDissmis)
            return
        }
        confirmationVM?.checkin(place: placeId) { [weak self] isSuccess, error in
            self?.submitButton.isHidden = true
            self?.statusLabel.text = isSuccess ? __("confirmation_screen_success_title") : __("confirmation_screen_failed_title")
            self?.subStatusLabel.text = isSuccess ? __("confirmation_screen_success_subTitle") : __("confirmation_screen_failed_subTitle")
            self?.statusStackView.isHidden = false
            if let error = error {
                print("🔴 \(error)")
            }
        }
    }
}

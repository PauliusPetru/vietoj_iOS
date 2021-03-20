import UIKit

final class ConfirmationVC: UIViewController {
    
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private weak var statusStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var adressLabel: UILabel!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var subStatusLabel: UILabel!
    
    private var confirmationVM: ConfirmationVM?
    
    var onDissmis: (() -> ())?
//    var dataModel: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmationVM = ConfirmationVM()
        setupUI()
    }
    
    @objc
    private func dismiss(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: onDissmis)
    }
    
    private func setupUI() {
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector (self.dismiss (_:)))
        backgroundView.addGestureRecognizer(gestureRecognizer)
        statusStackView.isHidden = true
        
        
        //TODO: show data from data model
    }
    @IBAction private func submitAction(_ sender: Any) {
        submitButton.isHidden = true
        statusStackView.isHidden = false
    }
}

import UIKit

final class ConfirmationVC: UIViewController {
    
    @IBOutlet private var backgroundView: UIView!
    
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
        
        //TODO: show data from data model
    }
    
    
}

import UIKit

final class ConfirmationVC: UIViewController {
    
    @IBOutlet private var backgroundView: UIView!
    
    var onDissmis: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector (self.dismiss (_:)))
        backgroundView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    func dismiss(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: onDissmis)
    }
}

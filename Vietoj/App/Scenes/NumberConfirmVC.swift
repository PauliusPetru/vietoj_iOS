import UIKit

final class NumberConfirmVC: UIViewController {
    
    private var numberConfirmVM: NumberConfirmVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberConfirmVM = NumberConfirmVM()
    }
}

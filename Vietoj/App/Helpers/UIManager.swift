import UIKit

final class UIManager {
    
    static func replaceRootController(with vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let windowScene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first
        
        guard let window = windowScene?.windows.first else { return }
        
        if animated {
           UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
               let oldState = UIView.areAnimationsEnabled
               UIView.setAnimationsEnabled(false)
               window.rootViewController = vc
               UIView.setAnimationsEnabled(oldState)
           }, completion: { _ in
               completion?()
           })
       } else {
           window.rootViewController = vc
           completion?()
       }
    }
    
    class func logout() {
        KeychainManager.shared.set(token: nil)
        KeychainManager.shared.set(name: nil)
        goToAuth()
    }
    
    class func goToAuth() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegistrationVC")
        replaceRootController(with: vc)
    }
    
    class func goToMainScreen() {
        //cia gal reiktu ne replacint o sukist visus tuos kitus langus i navigation istorija, tada useris gales tiesiog spaust back ir gris atgal.
        //Nes jei nesukisam i istorija ir nores is naujo registruotis replacins gal nelabai nice.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        replaceRootController(with: vc)
    }
    
    class var isLoggedIn: Bool {
        KeychainManager.shared.getToken() != nil
    }
}

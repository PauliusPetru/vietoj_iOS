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
        goToAuth()
    }
    
    class func goToAuth() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //TODO: has to be registration VC identifier
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        replaceRootController(with: vc)
    }
    
    class func goToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        replaceRootController(with: vc)
    }
    
    class var isLoggedIn: Bool {
        KeychainManager.shared.getToken() != nil
    }
}

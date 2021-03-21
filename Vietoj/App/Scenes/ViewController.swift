//
//  ViewController.swift
//  Vietoj
//
//  Created by T1406 on 2021-03-20.
//

import UIKit

class ViewController: UIViewController {
    
    func showAllert(title: String, message: String, handler: (() -> ())? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in handler?() }))
        present(alert, animated: true)
    }
}

extension UIViewController {
    func dismissKeyboardOnTap(cancelsTouchesInView: Bool = true) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = cancelsTouchesInView
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

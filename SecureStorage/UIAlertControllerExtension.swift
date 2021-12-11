//
//  UIAlertControllerExtension.swift
//  Secure Storage
//
//  Created by ENCIPHERS
//  Copyright © 2019 . All rights reserved.
//

import UIKit

extension UIAlertController {
    class func showAlert(with error: Error, on viewController: UIViewController) {
        let alertController = UIAlertController(title: "Secure Storage", message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        viewController.present(alertController, animated: true)
    }
    class func showAlert(with message: String, on viewController: UIViewController) {
        let alertController = UIAlertController(title: "Secure Storage", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        viewController.present(alertController, animated: true)
    }
    
    class func showTextInputAlert(with message: String, on viewController: UIViewController, completion: @escaping ((String?) -> Void)) {
        let alertController = UIAlertController(title: "Secure Storage", message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.text = ""
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alertController] (_) in
            completion(alertController?.textFields?.first?.text)
        }))
        viewController.present(alertController, animated: true)
    }
}

//
//  LoginViewViewController.swift
//  Secure Storage
//
//  Created by ENCIPHERS.
//  Copyright © 2019 . All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {

    var selectedIndex : Int = 1
    @IBOutlet weak var txtfUserName: UITextField!{
        didSet{
            self.txtfUserName.roundCorner4Px()
        }
    }
    
    @IBOutlet weak var txtfPassword: UITextField!{
        didSet{
            self.txtfPassword.roundCorner4Px()
        }
    }
    @IBOutlet weak var txtfConfirmPassword: UITextField!{
        didSet{
            self.txtfConfirmPassword.roundCorner4Px()
        }
    }
    @IBOutlet weak var btnSignUp: UIButton!{
        didSet{
            self.btnSignUp.roundCorner4Px()
        }
    }
    
    
    
    @IBAction func btnSignUpClicked(_ sender: UIButton?) {
        if self.txtfUserName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 == 0 || self.txtfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 == 0 || self.txtfConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 == 0{
            UIAlertController.showAlert(with: "Please Enter all values", on: self)
            return
        }
        if self.txtfPassword.text != self.txtfConfirmPassword.text {
            UIAlertController.showAlert(with: "Password not matching", on: self)
            return
        }
        
        Utility.setPassword(password: self.txtfPassword.text ?? "", forUserName: self.txtfUserName.text ?? "")
        Utility.setUserName(self.txtfUserName.text ?? "")
        let vc = UIStoryboard.getAfterLoginViewController()
        self.navigationController?.setViewControllers([vc], animated: true)
    
        
    }
    @IBAction func btnSignInClicked(_ sender: UIButton?) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtfUserName.delegate = self
        self.txtfPassword.delegate = self
        self.txtfConfirmPassword.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.deregisterFromKeyboardNotifications()
    }
}
extension SignUpViewController {
    @objc func keyboardWasShown(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame = CGRect(x: 0, y: -(keyboardSize.height/4), width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
extension SignUpViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.autocorrectionType = .no
        self.selectedIndex = textField.tag
        return true
    }
}

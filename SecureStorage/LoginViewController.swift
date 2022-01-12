//
//  LoginViewViewController.swift
//  Secure Storage


import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtFEmail: UITextField!{
        didSet{
            self.txtFEmail.roundCorner4Px()
        }
    }
    @IBOutlet weak var txtFPassword: UITextField!{
        didSet{
            self.txtFPassword.roundCorner4Px()
        }
    }
    @IBOutlet weak var btnLogin: UIButton!{
        didSet{
            self.btnLogin.roundCorner4Px()
        }
    }
    
    @IBOutlet weak var btnSignUpNow: UIButton!
    
    var tapCount : Int = 0
    
    
    
    @IBAction func btnLoginClicked(_ sender: Any?) {
    
        if self.txtFEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 == 0 || self.txtFPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 == 0{
            self.presentAlert(withTitle: "Error", message: "Please enter user name and password!")
        } else {
            let password = self.txtFPassword.text ?? "XX"
            let userName = self.txtFEmail.text ?? "X"
            if password == Utility.getPassword(forUserName: userName){
                Utility.setPassword(password: password, forUserName: userName)
                Utility.setUserName(userName)
                let vc = UIStoryboard.getAfterLoginViewController()
                self.navigationController?.setViewControllers([vc], animated: true)
                
            } else{
                self.presentAlert(withTitle: "Error", message: "Please enter a valid password or username, if not registered go to sign up page.")
            }
        }
    }
    
    @IBAction func btnSignUpNowClicked(_ sender: Any?) {
        let vc = UIStoryboard.getSignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFEmail.delegate = self
        self.txtFPassword.delegate = self
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
extension LoginViewController {
    @objc func keyboardWasShown(_ notification: Notification) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        /*if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue { self.view.frame = CGRect(x: 0, y: -(keyboardSize.height/4), width: self.view.frame.width, height: self.view.frame.height) }*/
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
extension LoginViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
extension UIViewController {

  func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        print("You've pressed OK Button")
    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

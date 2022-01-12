//
//  ProUserPaymentViewController.swift
//  Secure Storage


import UIKit



class ProUserPaymentViewController: UIViewController {
    
    var existingCard : [String : String]?
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var txtFCardNmber: UITextField!{
        didSet{
            self.txtFCardNmber.roundCorner4Px()
        }
    }
    @IBOutlet weak var txtFExpiry: UITextField!{
        didSet{
            self.txtFExpiry.roundCorner4Px()
        }
    }
    @IBOutlet weak var txtFCVV: UITextField!{
        didSet{
            self.txtFCVV.roundCorner4Px()
        }
    }
    @IBOutlet weak var txtFNameOnCard: UITextField!{
        didSet{
            self.txtFNameOnCard.roundCorner4Px()
        }
    }
    @IBOutlet weak var btnPayment: UIButton!{
        didSet{
            self.btnPayment.roundCorner4Px()
        }
    }
    
    
    
    @IBAction func btnPaymentTapped(_ sender: Any) {
        
        if (self.txtFCardNmber.text?.count) ?? 0 != 16{
            UIAlertController.showAlert(with: "Please enter a valid card number", on: self)
            return
        }
        if (self.txtFCardNmber.text?.count) ?? 0 == 16 {
            if let number = Int64(self.txtFCardNmber.text!){
                if number < 1000000000000000{
                    UIAlertController.showAlert(with: "Please enter a valid card number", on: self)
                    return
                }
            } else {
                UIAlertController.showAlert(with: "Please enter a valid card number", on: self)
                return
            }
        }
        if (self.txtFNameOnCard.text?.count) ?? 0 < 2{
            UIAlertController.showAlert(with: "Please enter a valid name", on: self)
            return
        }
        if (self.txtFCVV.text?.count) ?? 0 != 3{
            UIAlertController.showAlert(with: "Please enter a valid cvv", on: self)
            return
        }
        if (self.txtFCVV.text?.count) ?? 0 == 3{
            if let number = Int64(self.txtFCVV.text!){
                if number < 0 || number > 999{
                    UIAlertController.showAlert(with: "Please enter a valid cvv", on: self)
                    return
                }
            }
            else{
                UIAlertController.showAlert(with: "Please enter a valid cvv", on: self)
                return
            }
            
        }
        if (self.txtFExpiry.text?.count) ?? 0  != 5{
            UIAlertController.showAlert(with: "Please enter a valid expiry", on: self)
            return
        }
        if self.getExpiryDateWithString(dateStr: self.txtFExpiry.text) == nil{
            UIAlertController.showAlert(with: "Please enter a valid expiry", on: self)
            return
        }
        var card = [String : String]()
        card["cardnumber"] = self.txtFCardNmber.text
        card["cardname"] = self.txtFNameOnCard.text
        card["cardcvv"] = self.txtFCVV.text
        card["cardexpiry"] = self.txtFExpiry.text
        if existingCard != nil {
            Utility.replace(card: existingCard!, replacedCard: card)
            UIAlertController.showAlert(with: "Card updated", on: self)
        } else {
            Utility.save(card: card)
            UIAlertController.showAlert(with: "New Card Added", on: self)
        }
        
        
        
    }
    func getExpiryDateWithString(dateStr : String?) -> Date?{
        if dateStr == nil || (dateStr?.count) ?? 0 == 0 {
            return nil
        }
        var dateString = "01/"
        dateString = dateString + dateStr!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd/MM/YY"
        return dateFormatter.date(from: dateString)
    }
    func addTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProUserPaymentViewController.done))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func done(){
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGesture()
        self.txtFCardNmber.delegate = self
        self.txtFExpiry.delegate = self
        self.txtFCVV.delegate = self
        self.txtFNameOnCard.delegate = self
        self.btnPayment.layer.cornerRadius = 5.0
        self.btnPayment.clipsToBounds = true
        
        if self.existingCard != nil {
            self.btnPayment.setTitle("Edit Card Details", for: .normal)
            self.txtFCardNmber.text = self.existingCard?["cardnumber"]
            self.txtFNameOnCard.text = self.existingCard?["cardname"]
            self.txtFCVV.text = self.existingCard?["cardcvv"]
            self.txtFExpiry.text = self.existingCard?["cardexpiry"]
        } else {
            self.btnPayment.setTitle("Add Card Details", for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.deregisterFromKeyboardNotifications()
    }
    
}
extension ProUserPaymentViewController {
    @objc func keyboardWasShown(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame = CGRect(x: 0, y: -(keyboardSize.height/1.5), width: self.view.frame.width, height: self.view.frame.height)
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
extension ProUserPaymentViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0{
            if textField == self.txtFCVV{
                if (textField.text?.count) ?? 0 == 3{
                    textField.text = String(textField.text!.prefix(2))
                }
            }
            return true
        }
        else {
            if textField == self.txtFCardNmber{
                if (textField.text?.count) ?? 0 < 16{ return true } else { return false }
            } else if textField == self.txtFNameOnCard{
                if (textField.text?.count) ?? 0 < 30{ return true } else { return false }
            } else if textField == self.txtFExpiry{
                if (textField.text?.count) ?? 0 < 5{
                    if (textField.text?.count) ?? 0 == 2{
                        textField.text = textField.text! + "/"
                    }
                    return true
                } else { return false }
            } else if textField == self.txtFCVV{
                if (textField.text?.count) ?? 0 < 3{ return true} else {return false}
            }
        }
        return true
    }
}

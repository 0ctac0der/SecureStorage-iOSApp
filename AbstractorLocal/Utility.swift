//
//  Utility.swift
//  AbstractorLocal
//
//  Created by Mohammad Haroon on 14/11/21.
//

import Foundation
import CryptoKit

class Utility {
    
    static let AppEKeyString = "2D4A614E635266556A586E3272357538782F413F4428472B4B6250655367566B"
    
    static let AppEKey = SymmetricKey(data: Data(hexString:Utility.AppEKeyString)!)
    
    class func getNonceKey() -> Data?{
        //return Data(hexString: "546A576E5A723475")!
        //let tempString = "546A576E5A723475"
        if let keyString = UserDefaults.standard.string(forKey: "AppNonceKeyValue") {
            return Data(hexString: keyString)!
        }
        return nil
    }
    class func setNonce(_ value: String){
        UserDefaults.standard.set(value, forKey: "AppNonceKeyValue")
    }
    
    class func getEncryptionTag() -> Data? {
        //return Data(hexString: "214125442A472D4B")!
        //let tempString = "214125442A472D4B"
        if let keyString = UserDefaults.standard.string(forKey: "AppTagKeyValue"){
            return Data(hexString: keyString)!
        }
        return nil
    }
    
    class func setEncryptionTag(_ value: String){
        UserDefaults.standard.set(value, forKey: "AppTagKeyValue")
    }
    
    class func setUserName(_ value : String){
        UserDefaults.standard.set(value, forKey: "UserNameForLogin")
    }
    
    class func getUserName() -> String{
        return UserDefaults.standard.string(forKey: "UserNameForLogin") ?? "NoName"
    }
    
    class func setPassword(password : String, forUserName : String){
        UserDefaults.standard.set(password, forKey: forUserName + "Password")
    }
    
    class func getPassword(forUserName : String) -> String{
        return UserDefaults.standard.string(forKey: forUserName + "Password") ?? "XXX"
    }
    
    class func getCards() -> [[String : String]]{
        if let data = UserDefaults.standard.string(forKey: Utility.getUserName() + "Cardsdata") {
            let cleanString = data.decrypt()
            return Utility.toArrayOfDictionary(dataString: cleanString) ?? [[String : String]]()
        }
        return [[String : String]]()
    }
    
    class func delete(card : [String : String]){
        var arrCard = Utility.getCards()
        arrCard.removeAll { obj in
            obj["cardnumber"] == card["cardnumber"]
        }
        Utility.saveCards(arrCard)
    }
    
    class func replace(card : [String : String], replacedCard : [String : String]){
        var arrCard = Utility.getCards()
        arrCard.removeAll { obj in
            obj["cardnumber"] == card["cardnumber"]
        }
        arrCard.append(replacedCard)
        Utility.saveCards(arrCard)
    }
    /*
     card["cardnumber"] = self.txtFCardNmber.text
     card["cardname"] = self.txtFNameOnCard.text
     card["cardcvv"] = self.txtFCVV.text
     card["cardexpiry"] = self.txtFExpiry.text
     */
    class func save(card : [String : String]){
        var arrCard = Utility.getCards()
        arrCard.removeAll { obj in
            obj["cardnumber"] == card["cardnumber"]
        }
        arrCard.append(card)
        Utility.saveCards(arrCard)
    }
    
    class func saveCards(_ allCards : [[String : String]]){
        let string = Utility.toJSONString(arrayObject: allCards) ?? ""
        let stringData = string.encrypt()// ?? [UInt8]()
        UserDefaults.standard.set(stringData, forKey: Utility.getUserName() + "Cardsdata")
    }
    
    class func toJSONString(arrayObject: [[String : String]]) -> String? {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }
            
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }
    class func toArrayOfDictionary(dataString : String) -> [[String : String]]?{
        
        let data = Data(dataString.utf8)
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
                return json
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return nil
        
    }
    
}

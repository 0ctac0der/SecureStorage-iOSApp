//
//  StringExtension.swift
//  Secure Storage

import Foundation
import CryptoKit
import RNCryptor


extension String
{
    public func getServerFormattedDate() -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZ"
        if let date = formatter.date(from: self){return date}
        return nil
    }
    
    /*
     */
    func decrypt() -> String {
        if let encryptedData = Data.init(base64Encoded: self){
            if let decryptedData = try? RNCryptor.decrypt(data: encryptedData, withPassword: Utility.AppEKeyString){
                if let decryptedString = String(data: decryptedData, encoding: .utf8){
                    return decryptedString
                }
            }
        }
        return ""
    }
    func encrypt() -> String {
        if let messageData = self.data(using: .utf8){
            let cipherData = RNCryptor.encrypt(data: messageData, withPassword: Utility.AppEKeyString)
            return cipherData.base64EncodedString()
        }
        return ""
        
        
        /*
        let plainData = [UInt8] (self.utf8)
        let key = [UInt8] (Utility.AppEKeyString.utf8)
        var encrypted = [UInt8]()

        // encrypt bytes
        for (index, item) in plainData.enumerated() {
            encrypted.append(item ^ key[index])
        }
        return encrypted
        
        
        
        if let cryptedBox = try? ChaChaPoly.seal(plainData!, using: Utility.AppEKey), let sealedBox = try? ChaChaPoly.SealedBox(combined: cryptedBox.combined) {
            Utility.setNonce(sealedBox.nonce.withUnsafeBytes{ Data(Array($0)).hexadecimal })
            Utility.setEncryptionTag(sealedBox.tag.hexadecimal)
            return sealedBox.ciphertext
        }
        
        if let sealedData =  try? ChaChaPoly.seal(plainData!, using: Utility.AppEKey, nonce: noce){
            let nonceValue = sealedData.nonce.withUnsafeBytes { Data(Array($0)).hexadecimal }
            print("Nonce: \(nonceValue)")
            Utility.setNonce(nonceValue)
            let tagValue = sealedData.tag.hexadecimal
            print("Tag: \(tagValue)")
            Utility.setEncryptionTag(tagValue)
            return sealedData.ciphertext
        }*/
        //return Data()
    }
}
extension Array where Element : Numeric{
    func decrypt() -> String{
        var decrypted = [UInt8]()
        let key = [UInt8] (Utility.AppEKeyString.utf8)
        // decrypt bytes
        for (index, item) in self.enumerated() {
            if let ourItem = item as? UInt8{
                decrypted.append(ourItem ^ key[index])
            }
            
        }

        return String(bytes: decrypted, encoding: .utf8) ?? ""
    }
}
extension Data {
    func decrypt() -> String{
        
        
        /*
        if let sealedBoxData = try? ChaChaPoly.seal(self, using: Utility.AppEKey).combined{
            if let sealedBox = try? ChaChaPoly.SealedBox(combined: sealedBoxData){
                if let decryptedData = try? ChaChaPoly.open(sealedBox, using: Utility.AppEKey){
                    return String(data: decryptedData, encoding: .utf8) ?? ""
                }
            }
            

        }
        
        
        if let nonce = Utility.getNonceKey(), let tag = Utility.getEncryptionTag(){
            if let sealedBox = try? ChaChaPoly.SealedBox(nonce: ChaChaPoly.Nonce(data: nonce),
                                                   ciphertext: self,
                                                      tag: tag){
                if let decryptedData = try? ChaChaPoly.open(sealedBox, using: Utility.AppEKey){
                    return String(decoding: decryptedData, as: UTF8.self)
                }
            }
        }
        */
        return ""

    }
}

//
//  NSObjectExtension.swift
//  Secure Storage
//
//  Created by ENCIPHERS.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import CryptoKit


extension NSObject {
    var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
extension Data {
    
    init?(hexString: String) {
      let len = hexString.count / 2
      var data = Data(capacity: len)
      var i = hexString.startIndex
      for _ in 0..<len {
        let j = hexString.index(i, offsetBy: 2)
        let bytes = hexString[i..<j]
        if var num = UInt8(bytes, radix: 16) {
          data.append(&num, count: 1)
        } else {
          return nil
        }
        i = j
      }
      self = data
    }
    var hexadecimal: String {
        return map { String(format: "%02x", $0) }
            .joined()
    }
}

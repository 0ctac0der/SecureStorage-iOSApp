//
//  DateExtension.swift
//  Secure Storage
//
//  Created by ENCIPHERS.
//  Copyright © 2019 . All rights reserved.
//

import Foundation

extension Date
{
    public func toServerDateString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZ"
        return formatter.string(from: self)
    }
    public func getDisplayDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy"
        return formatter.string(from: self)
    }
}

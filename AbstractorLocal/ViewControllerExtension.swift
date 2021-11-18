//
//  ViewControllerExtension.swift
//  Abstractors
//
//  Created by ENCIPHERS.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

extension UIViewController {
    static var storyboardID: String {
        return className
    }
}
extension UIView {
    func roundCorner4Px(){
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
    }
    func roundCorner8Px(){
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
}

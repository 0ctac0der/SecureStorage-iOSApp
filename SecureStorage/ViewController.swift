//
//  ViewController.swift
//  AbstractorLocal
//
//  Created by Mohammad Haroon on 13/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let root = UIStoryboard.getLoginViewController()
            let navCont = UINavigationController.init(rootViewController: root)
            navCont.modalPresentationStyle = .fullScreen
            self.present(navCont, animated: true, completion: nil)
        }
    }


}


//
//  StoryboardExtension.swift
//  Secure Storage


import UIKit
extension UIStoryboard {
    fileprivate static let main = UIStoryboard(name: "Main", bundle: nil)
    
    
    func getViewController<T: UIViewController>() -> T {
        return instantiateViewController(withIdentifier: T.storyboardID) as! T
    }
    
    class func getLoginViewController() -> LoginViewController {
        return main.getViewController()
    }
    class func getSignUpViewController() -> SignUpViewController {
        return main.getViewController()
    }
    class func getProUserPaymentViewController() -> ProUserPaymentViewController {
        return main.getViewController()
    }
    class func getUsersViewController() -> UsersViewController {
        return main.getViewController()
    }
    class func getAfterLoginViewController() -> AfterLoginViewController {
        return main.getViewController()
    }
    class func getCardsViewController() -> CardsViewController{
        return main.getViewController()
    }
}

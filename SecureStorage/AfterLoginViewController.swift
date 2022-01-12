//
//  AfterLoginViewController.swift


import UIKit

class AfterLoginViewController: UIViewController {

    @IBOutlet weak var btnSAveCardInfo: UIButton!{
        didSet{
            self.btnSAveCardInfo.roundCorner4Px()
        }
    }
    @IBOutlet weak var btnCardDetails: UIButton!{
        didSet{
            self.btnCardDetails.roundCorner4Px()
        }
    }
    @IBOutlet weak var btnEditDeleteCardDetails: UIButton!{
        didSet{
            self.btnEditDeleteCardDetails.roundCorner4Px()
        }
    }
    @IBOutlet weak var btnLogout: UIButton!{
        didSet{
            self.btnLogout.roundCorner4Px()
        }
    }
    
    @IBAction func btnSaveCardDetailsClicked(_ sender: UIButton) {
        let vc = UIStoryboard.getProUserPaymentViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnCardDetailsClicked(_ sender: UIButton) {
        let vc = UIStoryboard.getCardsViewController()
        vc.isEditMode = false
        vc.dataSource = Utility.getCards()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnEditDeleteCardDetailClicked(_ sender: UIButton) {
        let vc = UIStoryboard.getCardsViewController()
        vc.isEditMode = true
        vc.dataSource = Utility.getCards()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        let vc = UIStoryboard.getLoginViewController()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

   
}

//
//  CardsViewController.swift


import UIKit

protocol CardsDetailCellDelegate : AnyObject{
    func editCardClicked(card: [String : String])
    func deleteCardClicked(card: [String : String])
}
class CardsDetailCell : UITableViewCell{
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblNameOnCard: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var lblCVV: UILabel!
    
    @IBOutlet weak var stkViewButtons: UIStackView!
    @IBOutlet weak var btnEdit: UIButton!{
        didSet{
            self.btnEdit.roundCorner4Px()
        }
    }
    @IBOutlet weak var btnDelete: UIButton!{
        didSet{
            self.btnDelete.roundCorner4Px()
        }
    }
    var card : [String : String]!
    weak var delegate : CardsDetailCellDelegate?
    
    func setUp(card : [String : String], delegate : CardsDetailCellDelegate, editMode : Bool){
        self.delegate = delegate
        self.card = card
        self.stkViewButtons.isHidden  = !editMode
        self.lblCardNumber.text = card["cardnumber"]
        self.lblNameOnCard.text = card["cardname"]
        self.lblCVV.text = card["cardcvv"]
        self.lblExpiryDate.text = card["cardexpiry"]
        
    }
    @IBAction func btnEditClicked(_ sender: UIButton) {
        self.delegate?.editCardClicked(card: self.card)
    }
    
    @IBAction func btnDeleteClicked(_ sender: UIButton) {
        self.delegate?.deleteCardClicked(card: self.card)
    }
    
}

class CardsViewController: UIViewController {
    
    @IBOutlet weak var tblViewCards: UITableView!{
        didSet{
            self.tblViewCards.delegate = self
            self.tblViewCards.dataSource = self
        }
    }
    var dataSource : [[String : String]]?
    var isEditMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataSource = Utility.getCards()
        self.tblViewCards.reloadData()
    }

}
extension CardsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell : CardsDetailCell = tableView.dequeueReusableCell(withIdentifier: "CardsDetailCell", for: indexPath) as? CardsDetailCell{
            cell.setUp(card: self.dataSource?[indexPath.row] ?? [String : String](), delegate: self, editMode: self.isEditMode)
            return cell
        }
        return UITableViewCell()
        
    }
}
extension CardsViewController : CardsDetailCellDelegate {
    func editCardClicked(card: [String : String]) {
        let vc = UIStoryboard.getProUserPaymentViewController()
        vc.existingCard = card
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteCardClicked(card: [String : String]) {
        Utility.delete(card: card)
        UIAlertController.showAlert(with: "Card deleted", on: self)
        self.dataSource = Utility.getCards()
        self.tblViewCards.reloadData()
    }
    
    
}

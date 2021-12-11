//
//  UsersViewController.swift
//  Secure Storage
//
//  Created by Anand Kumar on 01/09/2019.
//  Copyright © 2019 Harry. All rights reserved.
//

import UIKit


private let pageSize = 10

protocol UserDetailCellDelegate {
    func clickedOnFollow(_ model: User?, index: Int, isFollow: Bool)
    func openUserPosts(_ username: String)
}
class User {
    
}
class UserDetailCell : UITableViewCell {
    
    @IBOutlet weak var viewContainer: UIView!{
        didSet{
            viewContainer.layer.cornerRadius = 8.0
            viewContainer.layer.shadowOffset = CGSize(width: 0, height: 0)
            viewContainer.layer.shadowColor = UIColor.black.cgColor
            viewContainer.layer.shadowOpacity = 0.2
            viewContainer.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var proLabel: UILabel!{
        didSet{
            self.proLabel.layer.cornerRadius = 4.0
            self.proLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!{
        didSet{
            self.followButton.layer.cornerRadius = 4.0
            self.followButton.clipsToBounds = true
        }
    }
    var user: User?
    var index = 0
    var delegate: UserDetailCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setViewModel(_ user: User, index:Int, delegate: UserDetailCellDelegate) {
        self.user = user
        self.index = index
        self.delegate = delegate
        
        
    }
    
}

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableViewObj: UITableView!
    var allUser: [User] = []
    var arrDataSource : [User] = []
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    var totalPages: Int = 0
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        pageNumberLabel.isHidden = true
        prevButton.isHidden = true
        nextButton.isHidden = true
    }
    
}

extension UsersViewController: UserDetailCellDelegate {
    func clickedOnFollow(_ model: User?, index: Int, isFollow: Bool) {
        
    }
    
    func openUserPosts(_ username: String) {
        
    }
    
    
}

extension UsersViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailCell", for: indexPath) as! UserDetailCell
        let user = self.arrDataSource[indexPath.row]
        cell.setViewModel(user, index: indexPath.row, delegate: self)
        return cell
    }
}

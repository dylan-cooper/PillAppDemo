//
//  ContactProfileTableViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-05.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ContactProfileTableViewController: UITableViewController {

    var contact:Friend!
    @IBOutlet weak var removeFriendCell: UITableViewCell!
    @IBOutlet weak var allowMessagesSwitch: UISwitch!
    @IBOutlet weak var phoneCell: UITableViewCell!
    @IBOutlet weak var emailCell: UITableViewCell!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactName.text = contact.name
        profileImage.image = contact.picture
        emailCell.detailTextLabel?.text = contact.email
        allowMessagesSwitch.isOn = contact.allowMessages
        profileImage.layer.masksToBounds = true
        view.layoutIfNeeded() // Force layout to fix the UIImageView radius issue
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell === removeFriendCell {
            let alert = UIAlertController(title: "Remove Friend", message: "Are you sure you want to remove this friend?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let acceptAction = UIAlertAction(title: "Yes", style: .default) { [weak self] (action) in
                self?.performSegue(withIdentifier: "removedFriend", sender: self)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(acceptAction)
            present(alert, animated: true, completion: nil)
            alert.view.tintColor = UIColor.pillBlue
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

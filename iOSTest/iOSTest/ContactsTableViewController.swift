//
//  ContactsTableViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-05.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    var friends = [Friend]()
    var pendingFriends = [String]()
    
    var selectedFriend:Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends.append(Friend(name: "Monica Geller",
                              email: "mgeller@gmail.com",
                              picture: UIImage(imageLiteralResourceName: "Monica"),
                              allowMessages: true))
        friends.append(Friend(name: "Phoebe Buffay",
                              email: "pbuffay@gmail.com",
                              picture: UIImage(imageLiteralResourceName: "Phoebe"),
                              allowMessages: true))
        friends.append(Friend(name: "Rachel Green",
                              email: "rgreen@gmail.com",
                              picture: UIImage(imageLiteralResourceName: "Rachel"),
                              allowMessages: false))
        friends.append(Friend(name: "Joey Tribbiani",
                              email: "jtribbiani@gmail.com",
                              picture: UIImage(imageLiteralResourceName: "Joey"),
                              allowMessages: true))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ContactProfileTableViewController {
            vc.contact = selectedFriend
        }
    }
    
    @IBAction func unwindToFriends(_ sender: UIStoryboardSegue) {
        if sender.identifier == "sentFriendRequest" {
            let vc = sender.source as! AddContactTableViewController
            pendingFriends.append(vc.emailField.text!)
        }
        if sender.identifier == "removedFriend" {
            friends.remove(at: friends.index { $0.name == selectedFriend.name }!)
        }
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if pendingFriends.count > 0 {
            return 2
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return friends.count
        }
        return pendingFriends.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Friends"
        }
        return "Pending Friends"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedFriend = friends[indexPath.row]
            performSegue(withIdentifier: "showFriendProfile", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 88
        }
        return 44
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! ContactTableViewCell
            cell.nameLabel.text = friends[indexPath.row].name
            cell.profileImage.image = UIImage(imageLiteralResourceName: String(friends[indexPath.row].name.split(separator: " ")[0]))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pendingFriendCell", for: indexPath)
            cell.textLabel?.text = pendingFriends[indexPath.row]
            return cell
        }
    }
}

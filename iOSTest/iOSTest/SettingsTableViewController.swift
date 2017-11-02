//
//  SettingsTableViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-02.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var signOutCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell === signOutCell {
            signOut()
        }
    }
    
    deinit {
        print("Goodbye to settings")
    }
    
    private func signOut() {
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseNavigationController") as! UINavigationController
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let view = window.rootViewController?.view else { return }
        
        let viewController = navController.viewControllers[0]
        UIView.transition(from: view, to: viewController.view, duration: 0.5, options: .transitionCrossDissolve, completion: nil)
        window.rootViewController = navController
    }
}

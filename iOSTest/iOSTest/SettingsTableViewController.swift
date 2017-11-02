//
//  SettingsTableViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-02.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var languageCell: UITableViewCell!
    @IBOutlet weak var signOutCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        if cell === signOutCell {
            presentSignOutDialog()
        }
    }
    
    deinit {
        print("Goodbye to settings")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let languageVC = segue.destination as? LanguageSettingsTableViewController {
            languageVC.previousViewController = self
            languageVC.selectedLanguage = languageCell.detailTextLabel?.text ?? "English"
        }
    }
    
    private func presentSignOutDialog() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let acceptAction = UIAlertAction(title: "Sign Out", style: .default) { [weak self] (action) in
            self?.signOut()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        present(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.pillBlue
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

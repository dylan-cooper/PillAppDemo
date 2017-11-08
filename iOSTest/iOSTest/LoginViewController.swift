//
//  ViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-10-14.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userSeparator: UIView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var passwordSeparator: UIView!
    @IBOutlet weak var loginErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        passwordField.resignFirstResponder()
        userNameField.resignFirstResponder()
        navigationController?.navigationBar.isHidden = false
        loginErrorMessage.transform = CGAffineTransform.identity
        loginErrorMessage.alpha = 0
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("Goodbye to log in")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? AccountAccessViewController else { return }
        if segue.identifier == "forgotUsername" {
            viewController.accessType = .username
        } else if segue.identifier == "forgotPassword" {
            viewController.accessType = .password
        }
    }
    
    @IBAction func unwindToLogin(_ segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func didBeginEditingUserName(_ sender: UITextField) {
        highlight(separator: userSeparator)
    }
    
    @IBAction func didEndEditingUserName(_ sender: UITextField) {
        unHighlight(separator: userSeparator)
    }
    
    @IBAction func didBeginEditingPassword(_ sender: UITextField) {
        highlight(separator: passwordSeparator)
    }
    
    @IBAction func didEndEditingPassword(_ sender: UITextField) {
        unHighlight(separator: passwordSeparator)
        sender.resignFirstResponder()
    }
    
    @IBAction func didTapDoneOnTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    private func highlight(separator:UIView) {
        separator.backgroundColor = UIColor(red: 0.009, green: 0.427, blue: 0.706, alpha: 1)
    }
    
    private func unHighlight(separator:UIView) {
        separator.backgroundColor = UIColor(red: 0.723, green: 0.723, blue: 0.723, alpha: 1)
    }
    
    @IBAction func didTapLogIn(_ sender: UIButton) {
        if userNameField.hasText && passwordField.hasText {
            let viewController = UIStoryboard(name: "TabController", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
            guard let window = UIApplication.shared.keyWindow else { return }
            guard let view = window.rootViewController?.view else { return }
            
            UIView.transition(from: view, to: viewController.view, duration: 0.5, options: .transitionCrossDissolve, completion: nil)
            window.rootViewController = viewController
        } else {
            userNameField.resignFirstResponder()
            passwordField.resignFirstResponder()
            UIView.animate(withDuration: 0.5) {
                self.loginErrorMessage.alpha = 1
                self.loginErrorMessage.transform = CGAffineTransform(translationX: 0, y: self.passwordField.frame.maxY + 24)
            }
        }
    }
}


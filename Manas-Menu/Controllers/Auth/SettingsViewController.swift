//
//  SettingsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 05.02.23.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FBSDKLoginKit


class SettingsViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
       
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(didTapDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(didTapSignOut))

    }
    
    
    @objc private func didTapDismiss(){
        self.dismiss(animated: true)
    }
      
    
    @objc func didSignIn()  {
        self.dismiss(animated: false)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc private func didTapSignOut() {
        FBSDKLoginKit.LoginManager().logOut()
        GIDSignIn.sharedInstance()?.signOut()
        try? Auth.auth().signOut()
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: LoginViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
}

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
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Sign out ", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(signOutButton)
        signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(didTapDismiss))

        configureConstraints()
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
    
    private func configureConstraints() {
        
        let signOutButtonConstraints = [
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(signOutButtonConstraints)
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

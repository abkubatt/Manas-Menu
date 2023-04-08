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
    
    private let roomAddressTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.backgroundColor = .textFieldCustomColor
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(
            string: "Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return textField
    }()
    
    private let saveRoodAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Save Room Address ", for: .normal)
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
        MainTabBarViewController.shared.checkUserForAdmin { role in
            if role != "teacher" {
                self.roomAddressTextField.isHidden = true
                self.saveRoodAddressButton.isHidden = true
            }
        }
        view.addSubview(roomAddressTextField)
        view.addSubview(saveRoodAddressButton)
        roomAddressTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(didTapDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(didTapSignOut))

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
        
        let roomAddressConstraints = [
            roomAddressTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            roomAddressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            roomAddressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ]
        
        let saveRoodAddressButtonConst = [
            saveRoodAddressButton.topAnchor.constraint(equalTo: roomAddressTextField.bottomAnchor, constant: 50),
            saveRoodAddressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(roomAddressConstraints)
        NSLayoutConstraint.activate(saveRoodAddressButtonConst)
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

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
}

//
//  ResetPasswordViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 09.03.23.
//

import UIKit
import FirebaseAuth


class ResetPasswordViewController: UIViewController,UITextFieldDelegate {
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .blue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reset Password"
        view.backgroundColor = .systemBackground
        view.addSubviews(emailTextField)
        view.addSubviews(sendButton)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.emailTextField.delegate = self
        configureConstraints()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    private func configureConstraints() {
        
        let emailTextFieldConstraints = [
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ]
        
        let sendButtonConstraints = [
            sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            sendButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(sendButtonConstraints)
    }

}

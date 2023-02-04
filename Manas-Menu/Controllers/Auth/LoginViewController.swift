//
//  LoginViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit
import Combine
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    private var viewModel = AuthenticationViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to your account"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
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
    
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let promptLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.tintColor = .gray
         label.text = "Have a account already?"
         label.font = .systemFont(ofSize: 14, weight: .regular)
         return label
     }()
     
     private let signUpButton: UIButton = {
         let button = UIButton(type: .system)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitle("Sign Up", for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 14)
         button.tintColor = .blue
         return button
     }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.isEnabled = false
        return button
    }()
    
    private let facebookLoginButton: FBLoginButton = {
       let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let googleLogInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var loginObserver: NSObjectProtocol?
    
    
    
    @objc private func didChangeEmailField() {
        viewModel.email = emailTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    @objc private func didChangePasswordField() {
        viewModel.password = passwordTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    private func bindViews() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        viewModel.$isAuthenticationFormValid.sink { [weak self] validationState in
            self?.loginButton.isEnabled = validationState
        }
        .store(in: &subscriptions)
        
        viewModel.$user.sink { [weak self] user in
            guard user != nil else { return }
            guard let vc = self?.navigationController?.viewControllers.first as? LoginViewController else { return }
            vc.dismiss(animated: true)
        }
        .store(in: &subscriptions)
        
        
        viewModel.$error.sink { [weak self] errorString in
            guard let error = errorString else { return }
            self?.presentAlert(with: error)
        }
        .store(in: &subscriptions)
    }
    
    
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    
    private func alreadyHaveAccountAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginObserver = NotificationCenter.default.addObserver(
            forName: .didLogInNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.navigationController?.dismiss(animated: true)
            })
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        
        title = "Log In"
        view.backgroundColor = .systemBackground
        facebookLoginButton.delegate = self
        view.addSubview(loginTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(promptLabel)
        view.addSubview(signUpButton)
//        facebookLoginButton.permissions = ["public_profile", "email"]
        view.addSubview(facebookLoginButton)
        for constraint in facebookLoginButton.constraints where constraint.firstAttribute == .height {
            constraint.constant = 39
        }
        view.addSubview(googleLogInButton)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        configureConstraints()
        bindViews()

    }
    
    deinit{
        if let observer = loginObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    @objc private func didTapSignUp() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLogin() {
        viewModel.loginUser()
    }
    
    private func configureConstraints() {
        let loginTitleLabelCosntraints = [
            loginTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ]
        
        
        let emailTextFieldConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        let loginButtonConstraints = [
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            loginButton.widthAnchor.constraint(equalToConstant: 140),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let promptLabelConstraints = [
           promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           promptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
       ]
               
       let signUpButtonConstraints = [
           signUpButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor),
           signUpButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 10)
       ]
        
     
        
        let googleLogInButtonConstraints = [
            googleLogInButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 25),
            googleLogInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            googleLogInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ]
        
        let facebookLoginButtonConstraints = [
             facebookLoginButton.topAnchor.constraint(equalTo: googleLogInButton.bottomAnchor,constant: 17),
             facebookLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
             facebookLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
         ]
        
        
        NSLayoutConstraint.activate(loginTitleLabelCosntraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
        NSLayoutConstraint.activate(promptLabelConstraints)
        NSLayoutConstraint.activate(signUpButtonConstraints)
        NSLayoutConstraint.activate(googleLogInButtonConstraints)
        NSLayoutConstraint.activate(facebookLoginButtonConstraints)
    }
}


extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        // no operation
    }
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        
        guard let token = result?.token?.tokenString else {
            print("User failed to log in with facebook")
            return
        }
        
//        let faceBookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
//                                                         parameters: ["fields": "email, name"],
//                                                         tokenString: token,
//                                                         version: nil,
//                                                         httpMethod: .get
//        )
//
//
//        faceBookRequest.start(completionHandler: {_, result, error in
//            guard let result = result as? [String: Any],
//                  error == nil else{
//                print("Failed to make facebook graph request")
//                return
//            }
//
//            guard let email = result["email"] as? String else{
//                print("Failed to get email from fb request")
//                return
//            }
//
//            Auth.auth().fetchSignInMethods(forEmail: email, completion: { (providers, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                    print("email not exists")
//                } else if let providers = providers {
//                    print(providers)
//                    self.alreadyHaveAccountAlert(with: "With this email account already exists")
//                    return
//                }
//            })
//        })
       
        
        
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
         
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            guard authResult != nil, error == nil  else{
                if let error = error {
                    print("Facebook credential login failed, MFA may be needed - \(error)")
                    
                }
                return
            }
            
            print("Successfully logged user in")
            strongSelf.navigationController?.dismiss(animated: true)
        })
    }
    
    
}

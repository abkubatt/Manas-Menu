//
//  AuthenticationViewViewModel.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import Foundation
import Firebase
import Combine

final class AuthenticationViewViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var user: User?
    @Published var error: String?
    
    
    private var subcriptions: Set<AnyCancellable> = []
    
    
    
    func validateAuthenticationForm() {
        guard let email = email,
              let password = password else{
            isAuthenticationFormValid = false
            return
        }
        isAuthenticationFormValid = isValidEmail(email) && password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func createUser() {
        guard let email = email,
              let password = password else{return}
        AuthManager.shared.registerUser(with: email, password: password)
            .handleEvents(receiveOutput: {[weak self] user in
                self?.user = user
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
                
            }receiveValue: { user in
                _ = user
//                print(user)
            }
            .store(in: &subcriptions)
    }
    
    
    
    func loginUser() {
        guard let email = email,
              let password = password else{return}
        AuthManager.shared.loginUser(with: email, password: password)
            .sink {  [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
                
            }receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subcriptions)
    }
}

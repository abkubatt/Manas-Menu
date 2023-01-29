//
//  HomeViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    lazy var carousel = Carousel(frame: .zero, urls: UniversityImages.urls)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(didTapSignOut))

        setupHierarchy()
        setupComponents()
        validateAuth()
        congfigureConstraints()
    }
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    func setupHierarchy() {
        self.view.addSubview(carousel)
    }
    
    func setupComponents() {
        carousel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func didTapSignOut() {
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
    
    
    private func congfigureConstraints() {
        
        let carouselContraints = [
            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            carousel.bottomAnchor.constraint(equalTo: carousel.topAnchor, constant: 180),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate(carouselContraints)
    }

}

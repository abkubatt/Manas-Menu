//
//  HomeViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
//    ScrollView(.horizontal, showsIndicators: false) {
//        HStack(spacing: 20) {
//            ForEach(0..<10) {
//                Text("Item \($0)")
//                    .foregroundColor(.white)
//                    .font(.largeTitle)
//                    .frame(width: 200, height: 200)
//                    .background(.red)
//            }
//        }
//    }
//
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .green
        scroll.showsHorizontalScrollIndicator = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.image = UIImage(named: "arka")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        view.addSubview(imageView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(didTapSignOut))
        

        validateAuth()
        congfigureConstraints()
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
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ]
        
        let imageViewContraints = [
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(imageViewContraints)
    }

}

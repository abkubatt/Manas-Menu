//
//  HomeViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController, RMCharacterListViewDelegate {
    lazy var carousel = Carousel(frame: .zero, urls: UniversityImages.urls)

    private let characterListView = RMCharacterListView()
    private let dbReference = Firestore.firestore().collection("menu")
    private var menus = [UserRole]()
    
    private let todayDateLabel: UILabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: Date())
        label.text = dateString
        
        
        label.font = label.font.withSize(20)
        label.textColor = .label
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints=false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints=false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo:scrollView.rightAnchor).isActive=true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.addArrangedSubview(carousel)
        carousel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        carousel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        stackView.setCustomSpacing(20, after: stackView.subviews[0])
        
        stackView.addArrangedSubview(todayDateLabel)
        todayDateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: self.view.frame.width / 2.85).isActive = true
        todayDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        stackView.setCustomSpacing(15, after: stackView.subviews[1])
        
        characterListView.delegate = self
        stackView.addArrangedSubview(characterListView)
        characterListView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        characterListView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        
        view.backgroundColor = .systemBackground
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        validateAuth()
        setUpView()
    }
    
        @objc private func didTapSettings(){
            let vc = UINavigationController(rootViewController: SettingsViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    
        private func validateAuth() {
            if FirebaseAuth.Auth.auth().currentUser == nil {
                let vc = UINavigationController(rootViewController: LoginViewController())
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false)
            }
        }

    private func setUpView(){
    }
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: Menu) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode  = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }

}


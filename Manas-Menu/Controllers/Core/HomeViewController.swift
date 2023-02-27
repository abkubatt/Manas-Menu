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


class HomeViewController: UIViewController, RMCharacterListViewDelegate {
        lazy var carousel = Carousel(frame: .zero, urls: UniversityImages.urls)

    private let characterListView = RMCharacterListView()
    
    private let todayDateLabel: UILabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: Date.now)
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
        
//        let imageView1 = UIImageView()
//        imageView1.image = UIImage (named: "yemek")
//        stackView.addArrangedSubview(imageView1)
//        imageView1.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        imageView1.heightAnchor.constraint (equalToConstant: 400).isActive = true
//
//        let imageView2 = UIImageView()
//        imageView2.image = UIImage(named: "yemek" )
//        stackView.addArrangedSubview(imageView2)
//        imageView2.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        imageView2.heightAnchor.constraint(equalToConstant: 400).isActive = true
        stackView.setCustomSpacing(20, after: stackView.subviews[0])
        
        stackView.addArrangedSubview(todayDateLabel)
        todayDateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: self.view.frame.width / 2.85).isActive = true
        todayDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        stackView.setCustomSpacing(15, after: stackView.subviews[1])
        
        characterListView.delegate = self
        stackView.addArrangedSubview(characterListView)
        characterListView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        characterListView.heightAnchor.constraint(equalToConstant: 600).isActive = true
//        view.addSubview(characterListView)
    
//        let carouselContraints = [
//                    carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//                    carousel.bottomAnchor.constraint(equalTo: carousel.topAnchor, constant: 180),
//                    carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//                    carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
//                ]
//
//                NSLayoutConstraint.activate(carouselContraints)
//        NSLayoutConstraint.activate([
//            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
//            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
        
        view.backgroundColor = .systemBackground
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
//        setupHierarchy()
//                setupComponents()
                validateAuth()
        setUpView()
    }
    
//    override func loadView() {
//            let view = UIView()
//            view.backgroundColor = .systemBackground
//            self.view = view
//        }

//        func setupHierarchy() {
//            self.view.addSubview(carousel)
//        }

//        func setupComponents() {
//            carousel.translatesAutoresizingMaskIntoConstraints = false
//        }
    
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

    // MARK: - RMCharacterListViewDelegate

    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        // Open details controller for that character
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode  = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }

}















//class HomeViewController: UIViewController {
//
//    lazy var carousel = Carousel(frame: .zero, urls: UniversityImages.urls)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Home"
//        view.backgroundColor = .systemBackground
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
//
//        setupHierarchy()
//        setupComponents()
//        validateAuth()
//        congfigureConstraints()
//    }
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .systemBackground
//        self.view = view
//    }
//
//    func setupHierarchy() {
//        self.view.addSubview(carousel)
//    }
//
//    func setupComponents() {
//        carousel.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    @objc private func didTapSettings(){
//        let vc = UINavigationController(rootViewController: SettingsViewController())
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
//    }
//
//
//
//    private func validateAuth() {
//        if FirebaseAuth.Auth.auth().currentUser == nil {
//            let vc = UINavigationController(rootViewController: LoginViewController())
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: false)
//        }
//    }
//
//
//    private func congfigureConstraints() {
//
//        let carouselContraints = [
//            carousel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            carousel.bottomAnchor.constraint(equalTo: carousel.topAnchor, constant: 180),
//            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
//        ]
//
//        NSLayoutConstraint.activate(carouselContraints)
//    }
//
//}

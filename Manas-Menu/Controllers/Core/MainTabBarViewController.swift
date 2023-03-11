//
//  ViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit

enum UserType {
    case admin
    case user
}

class MainTabBarViewController: UITabBarController {
    
    static let shared = MainTabBarViewController()
    
    var userType: UserType = .admin

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUpTabs(userType)
    }
    
    private func setUpTabs(_ userType: UserType) {
        
        let homeVC = HomeViewController()
        let yemekhane = CafeViewController()
        let kyraat = CanteenViewController()
        let manage = ManageViewController()
        
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        yemekhane.navigationItem.largeTitleDisplayMode = .automatic
        kyraat.navigationItem.largeTitleDisplayMode = .automatic
        manage.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: yemekhane)
        let nav3 = UINavigationController(rootViewController: kyraat)
        let nav4 = UINavigationController(rootViewController: manage)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        nav2.tabBarItem = UITabBarItem(title: "Cafe", image: UIImage(systemName: "fork.knife.circle"), selectedImage: UIImage(systemName: "fork.knife.circle.fill"))
        nav3.tabBarItem = UITabBarItem(title: "Canteen", image: UIImage(systemName: "cup.and.saucer"), selectedImage: UIImage(systemName: "cup.and.saucer.fill"))
        nav4.tabBarItem = UITabBarItem(title: "Manage", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        nav3.navigationBar.prefersLargeTitles = true
        
        switch userType {
        case .admin:
            setViewControllers([nav1, nav2, nav3, nav4], animated: true)
        case .user:
            setViewControllers([nav1, nav2, nav3], animated: true)
        }
    }
}


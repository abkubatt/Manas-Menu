//
//  ViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    
    private func setUpTabs() {
        
        let homeVC = HomeViewController()
        let yemekhane = CafeViewController()
        let kyraat = CanteenViewController()
        
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        yemekhane.navigationItem.largeTitleDisplayMode = .automatic
        kyraat.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: yemekhane)
        let nav3 = UINavigationController(rootViewController: kyraat)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        nav2.tabBarItem = UITabBarItem(title: "Cafe", image: UIImage(systemName: "fork.knife.circle"), selectedImage: UIImage(systemName: "fork.knife.circle.fill"))
        nav3.tabBarItem = UITabBarItem(title: "Canteen", image: UIImage(systemName: "cup.and.saucer"), selectedImage: UIImage(systemName: "cup.and.saucer.fill"))
        
//        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }


}


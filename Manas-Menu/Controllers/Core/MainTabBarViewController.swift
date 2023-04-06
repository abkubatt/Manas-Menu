//
//  ViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit
import Firebase


enum UserType {
    case admin
    case user
    case teacher
}

class MainTabBarViewController: UITabBarController {
    
    static let shared = MainTabBarViewController()
    
    var userType: UserType = .admin
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        checkUserForAdmin { role in
            if role == "admin" {
                self.setUpTabs(.admin)
            }else if role == "teacher" {
                self.setUpTabs(.teacher)
            }
            else{
                self.setUpTabs(.user)
            }
        }
        
    }
   
    
    private func checkUserForAdmin(completion: @escaping ((String) -> Void)){
        var response: String = ""
        guard let userUid = Auth.auth().currentUser?.uid else {
            if Auth.auth().currentUser?.uid == nil {
                completion("quest")
            }
            return
        }
        
        let documentRef = db.collection("roles").document(userUid)
        
        documentRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data ?? [:], options: [])
                    let model = try JSONDecoder().decode(UserRole.self, from: jsonData)
                
                    response = model.user_role ?? ""
                    completion(response)
                } catch {
                    _ = "Error decoding model: \(error)"
//                    print("Error decoding model: \(error)")
                }
            } else {
                 _ = "Document does not exist"
//                print("Document does not exist")
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkUserForAdmin { role in
            if role == "admin" {
                self.setUpTabs(.admin)
            }else if role == "teacher" {
                self.setUpTabs(.teacher)
            }
            else{
                self.setUpTabs(.user)
            }
        }
    }
    
    
    
    
    
    private func setUpTabs(_ userType: UserType) {
        
        let homeVC = HomeViewController()
        let yemekhane = CafeViewController()
        let kyraat = CanteenViewController()
        let manage = ManageViewController()
        let delivery = DeliveryViewController()
        
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        yemekhane.navigationItem.largeTitleDisplayMode = .automatic
        kyraat.navigationItem.largeTitleDisplayMode = .automatic
        manage.navigationItem.largeTitleDisplayMode = .automatic
        delivery.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: yemekhane)
        let nav3 = UINavigationController(rootViewController: kyraat)
        let nav4 = UINavigationController(rootViewController: manage)
        let nav5 = UINavigationController(rootViewController: delivery)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        nav2.tabBarItem = UITabBarItem(title: "Cafe", image: UIImage(systemName: "fork.knife.circle"), selectedImage: UIImage(systemName: "fork.knife.circle.fill"))
        nav3.tabBarItem = UITabBarItem(title: "Canteen", image: UIImage(systemName: "cup.and.saucer"), selectedImage: UIImage(systemName: "cup.and.saucer.fill"))
        nav4.tabBarItem = UITabBarItem(title: "Manage", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        nav5.tabBarItem = UITabBarItem(title: "Delivery", image: UIImage(systemName: "takeoutbag.and.cup.and.straw"), selectedImage: UIImage(systemName: "takeoutbag.and.cup.and.straw.fill"))
        
        nav3.navigationBar.prefersLargeTitles = true
        
        switch userType {
        case .admin:
            setViewControllers([nav1, nav2, nav3, nav4], animated: true)
        case .user:
            setViewControllers([nav1, nav2, nav3], animated: true)
        case .teacher:
            setViewControllers([nav1, nav2, nav3, nav5], animated: true)
        }
    }
}



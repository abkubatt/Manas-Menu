//
//  ManageViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 10.03.23.
//

import UIKit
import FirebaseFirestore



class ManageViewController: UIViewController {
    
    private let dbReference = Firestore.firestore().collection("menu")
    private var menus = [Menu]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manage"
        view.backgroundColor = .systemBackground
        fetchMenus()
    }

    func fetchMenus() {
        dbReference.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            self.menus = documents.compactMap{ document in
                do {
                    let menu = try document.data(as: Menu.self)
                    return menu
                } catch {
                    print("Error decoding Menu: \(error.localizedDescription)")
                    return nil
                }
            }
            print("Fetched Menus: \(self.menus)")
        }
    }


}

//
//  YemekhaneViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit

class CafeViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search foods"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cafe"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "yemek"), style: .plain, target: self, action: nil)

    }

}

//
//  KyraatViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit

class CanteenViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search foods"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Canteen"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Free Foods", style: .done, target: self, action: #selector(didTapFreeFoods))
    }
    
    
    
    
    @objc private func didTapFreeFoods() {
        
       let freeFoods = FreeFoodsViewController()
        freeFoods.modalPresentationStyle = .automatic
        present(freeFoods, animated: true)
   }
    
}

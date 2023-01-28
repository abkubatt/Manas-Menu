//
//  FreeFoodsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit

class FreeFoodsViewController: UIViewController {
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Free Foods"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search foods"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.translatesAutoresizingMaskIntoConstraints = false
//        controller.hidesNavigationBarDuringPresentation = false
        return controller
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = false
//        navigationItem.hidesSearchBarWhenScrolling = false
//        self.navigationController?.navigationBar.isHidden = false
        view.addSubview(searchController.searchBar)
//        navigationItem.searchController = searchController
//        searchController.searchBar.sizeToFit()
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let searchControllerConstraints = [
            searchController.searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            searchController.searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            searchController.searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(searchControllerConstraints)
    }
    
    

}

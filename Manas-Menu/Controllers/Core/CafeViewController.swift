//
//  YemekhaneViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit

//class CafeViewController: UIViewController {
//
//    let tableView: UITableView = {
//        let table = UITableView()
//        table.backgroundColor = .red
//        table.translatesAutoresizingMaskIntoConstraints = false
//        return table
//    }()
//
//    override func viewDidLoad() {
//       super.viewDidLoad()
//        title = "Cafe"
//        navigationItem.largeTitleDisplayMode = .automatic
//        view.backgroundColor = .systemBackground
//        view.addSubview(tableView)
//
//        configureConstraints()
//   }
//
//    private func configureConstraints() {
//
//        let tableViewConstraints = [
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ]
//
//        NSLayoutConstraint.activate(tableViewConstraints)
//    }
//
//}












final class CafeViewController: UIViewController, RMCharacterListViewDelegate {

    private let characterListView = RMCharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
    }

    private func setUpView(){
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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




































//
//
//
//class CafeViewController: UIViewController {
//
//    private let searchController: UISearchController = {
//        let controller = UISearchController(searchResultsController: SearchResultsViewController())
//        controller.searchBar.placeholder = "Search foods"
//        controller.searchBar.searchBarStyle = .minimal
//        return controller
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Cafe"
//        view.backgroundColor = .systemBackground
//        navigationItem.searchController = searchController
//    }
//
//}

//
//  YemekhaneViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit

class CafeViewController: UIViewController {
    private var menus = [MenusPerDay]()
    
    
    let menuTableView: UITableView = {
        let table = UITableView()
        let m = MenuTableViewCell()
        table.register(MenusTableViewCell.self, forCellReuseIdentifier: MenusTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
       super.viewDidLoad()
        title = "Cafe"
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .systemBackground
        view.addSubview(menuTableView)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        fetchUpcoming()
        configureConstraints()
   }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuTableView.frame = view.frame
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getMenus { [weak self] result in
            switch result {
            case.success(let menus):
                self?.menus = menus
                DispatchQueue.main.async {
                    self?.menuTableView.reloadData()
                }
            case.failure(let error):
                _ = error.localizedDescription
            }
        }
    }

    private func configureConstraints() {

        let tableViewConstraints = [
            menuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]

        NSLayoutConstraint.activate(tableViewConstraints)
    }

}

extension CafeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus[section].menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenusTableViewCell.identifier, for: indexPath) as? MenusTableViewCell else {return UITableViewCell()}
        
        let title = menus[indexPath.section].menus[indexPath.row]
        
        cell.configure(with: MenusViewModel(titleName: title.name, posterURL: title.image, calorie: title.calorie))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let title = menus[indexPath.row].menus[indexPath.row]
//
//        let titleName = title.name
//
//        APICaller.shared.getMovie(with: titleName) {[weak self] result in
//            switch result{
//            case .success(let videoElement):
//                DispatchQueue.main.async {
//                    let vc = TitlePreviewViewController()
//                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: "Calorie: \(title.calorie)"))
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                }
//            case .failure(let error):
//                _ = (error.localizedDescription)
//            }
//        }
    }
    

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menus[section].date
    }
    
    
}


















//final class CafeViewController: UIViewController, RMCharacterListViewDelegate {
//
//    private let characterListView = RMCharacterListView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        title = "Characters"
//        setUpView()
//    }
//
//    private func setUpView(){
//        characterListView.delegate = self
//        view.addSubview(characterListView)
//        NSLayoutConstraint.activate([
//            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//
//    // MARK: - RMCharacterListViewDelegate
//
//    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
//        // Open details controller for that character
//        let viewModel = RMCharacterDetailViewViewModel(character: character)
//        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
//        detailVC.navigationItem.largeTitleDisplayMode  = .never
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//
//}




































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

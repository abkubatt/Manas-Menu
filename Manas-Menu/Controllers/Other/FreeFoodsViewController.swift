//
//  FreeFoodsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit


class FreeFoodsViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    private var upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "UPCOMING"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.frame
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
}

extension FreeFoodsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        
        let title = titles[indexPath.row]
        
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unknown title name", posterURL: title.poster_path ?? ""))
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else {return}
        
        APICaller.shared.getMovie(with: titleName) {[weak self] result in
            switch result{
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}









//class FreeFoodsViewController: UIViewController {
//
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Free Foods"
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 18, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let searchController: UISearchController = {
//        let controller = UISearchController(searchResultsController: nil)
//        controller.searchBar.placeholder = "Search foods"
//        controller.searchBar.searchBarStyle = .minimal
//        controller.searchBar.translatesAutoresizingMaskIntoConstraints = false
////        controller.hidesNavigationBarDuringPresentation = false
//        return controller
//    }()
//
//    private let descriptionOfFreeFood: UILabel = {
//        let label = UILabel()
//        label.text = "Free food is provided by our philanthropic staff for students in need at the Turkish World Nation Coffeehouse. These services are carried out in accordance with a specially prepared digital program. Suspended food is paid for by volunteers at our university. In order to help our students in need, you can suspend any number of products in the cafeteria by paying the fee to the cashier."
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 15, weight: .light)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        return label
//    }()
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        view.addSubview(titleLabel)
//
////        searchController.obscuresBackgroundDuringPresentation = false
////        searchController.hidesNavigationBarDuringPresentation = false
////        navigationItem.hidesSearchBarWhenScrolling = false
////        self.navigationController?.navigationBar.isHidden = false
//        view.addSubview(searchController.searchBar)
//        view.addSubview(descriptionOfFreeFood)
////        navigationItem.searchController = searchController
////        searchController.searchBar.sizeToFit()
//        configureConstraints()
//    }
//
//    private func configureConstraints() {
//
//        let titleConstraints = [
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ]
//
//        let searchControllerConstraints = [
//            searchController.searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//            searchController.searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
//            searchController.searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7)
//        ]
//
//        let descriptionOfFreeFoodConstraints = [
//            descriptionOfFreeFood.topAnchor.constraint(equalTo: searchController.searchBar.bottomAnchor, constant: 8),
//            descriptionOfFreeFood.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
//            descriptionOfFreeFood.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6)
//        ]
//
//        NSLayoutConstraint.activate(titleConstraints)
//        NSLayoutConstraint.activate(searchControllerConstraints)
//        NSLayoutConstraint.activate(descriptionOfFreeFoodConstraints)
//    }
//
//
//
//}

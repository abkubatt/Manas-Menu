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
    
    private var randomTrendingMovie: Canteen?
    let sectionTitles: [String] = ["Drinks", "Pizza and Pides", "Bakery Products", "Desserts", "Other Foods"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Canteen"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Free Foods", style: .done, target: self, action: #selector(didTapFreeFoods))
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureHeroHeaderView()
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                
                self?.randomTrendingMovie = selectedTitle
            case .failure(let error):
                _ = error.localizedDescription
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    @objc private func didTapFreeFoods() {
        
       let freeFoods = FreeFoodsViewController()
        freeFoods.modalPresentationStyle = .automatic
        present(freeFoods, animated: true)
   }
    
}

extension CanteenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies {result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    _ = error.localizedDescription
                }
            }
         
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getPaP {result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    _ = error.localizedDescription
                }
            }

        case Sections.Popular.rawValue:
            APICaller.shared.getBakeryProducts {result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    _ = error.localizedDescription
                }
            }

        case Sections.Upcoming.rawValue:
            APICaller.shared.getDesserts {result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    _ = error.localizedDescription
                }
            }

        case Sections.TopRated.rawValue:
            APICaller.shared.getOtherFoods {result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    _ = error.localizedDescription
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.text = header.textLabel?.text?.uppercased()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
}

extension CanteenViewController: CollectionViewTableCellDelegate{
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


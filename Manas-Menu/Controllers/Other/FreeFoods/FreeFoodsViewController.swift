//
//  FreeFoodsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import UIKit


class FreeFoodsViewController: UIViewController {
    
    private var titles: [Canteen] = [Canteen]()
    
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
        APICaller.shared.getFreeFoods { [weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case.failure(let error):
                _ = error.localizedDescription
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
        
        cell.configure(with: TitleViewModel(titleName: (title.name), posterURL: title.image, countOfFood: title.amountForFree))
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
         let titleName = title.name
        
        APICaller.shared.getMovie(with: titleName) {[weak self] result in
            switch result{
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: "\(title.price)"))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                _ = error.localizedDescription
            }
        }
    }
    
}



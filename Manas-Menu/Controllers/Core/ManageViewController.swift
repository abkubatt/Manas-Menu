//
//  ManageViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 10.03.23.
//

import UIKit


class ManageViewController: UIViewController {
    
    private let images: [UIImage] = [
        UIImage(systemName: "calendar.badge.plus")!,
        UIImage(systemName: "square.and.pencil")!,
        UIImage(systemName: "trash")!,
        UIImage(systemName: "cup.and.saucer")!,
        UIImage(systemName: "square.and.pencil")!,
        UIImage(systemName: "trash")!,
        UIImage(systemName: "fork.knife")!,
        UIImage(systemName: "square.and.pencil")!,
        UIImage(systemName: "trash")!,
        
    ]
    
    private let titles: [String] = ["Add menu", "Update menu", "Delete menu", "Add canteen foods", "Update canteen foods", "Delete canteen foods", "Add free foods", "Update free foods", "Delete free foods"]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(ManageListTableViewCell.self, forCellReuseIdentifier: ManageListTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manage"
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        configureConstraints()

    }

    
    private func configureConstraints() {
        
        let tableViewContraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewContraints)

    }


}


extension ManageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ManageListTableViewCell.identifier, for: indexPath) as? ManageListTableViewCell else{
            fatalError("The TableView could not dequeue a ManageListUITableViewCell in ManageViewController.")
        }
        
        let image = self.images[indexPath.row]
        cell.configure(with: image, and: titles[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("DEBUG PRINT:", indexPath.row)
    }
    
    
}


    
    

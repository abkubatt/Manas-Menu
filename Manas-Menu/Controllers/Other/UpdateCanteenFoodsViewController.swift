//
//  UpdateCanteenFoodsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 13.03.23.
//

import UIKit

class UpdateCanteenFoodsViewController: UIViewController {

    var items = ["Coca Cola", "Fanta", "Pepsi", "Kofte", "Pizza", "Yougurt","Coca Cola", "Fanta", "Pepsi", "Kofte", "Pizza", "Yougurt","Coca Cola", "Fanta", "Pepsi", "Kofte", "Pizza", "Yougurt",]
    
    let idOfCanteenFood = 654
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MyDeleteTableViewCell.self, forCellReuseIdentifier: MyDeleteTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Delete Canteen Foods"
        view.backgroundColor = .systemBackground
        view.addSubviews(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    

}


extension UpdateCanteenFoodsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyDeleteTableViewCell.identifier, for: indexPath) as? MyDeleteTableViewCell else{
            return UITableViewCell()
        }

        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        cell.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailUpdateCanteenFoodsViewController()
        vc.configure(with: idOfCanteenFood)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

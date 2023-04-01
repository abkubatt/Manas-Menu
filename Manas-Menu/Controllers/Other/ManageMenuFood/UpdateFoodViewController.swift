//
//  UpdateFoodViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 17.03.23.
//

import UIKit

class UpdateFoodViewController: UIViewController {

    var menus = [Menu]()
    let getAllUrl = "http://192.168.242.250:8080/api/Menus"

    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MyDeleteTableViewCell.self, forCellReuseIdentifier: MyDeleteTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update Food"
        view.backgroundColor = .systemBackground
        self.getMenus()
        view.addSubviews(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func getMenus(){
        DispatchQueue.main.async {
            APICaller.shared.getAllMenuFood (with: self.getAllUrl){ result in
                switch result {
                case .success(let menus):
                    self.menus = menus
                case .failure(let error):
                    _ = error.localizedDescription
                }
                
            }
        }
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


extension UpdateFoodViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyDeleteTableViewCell.identifier, for: indexPath) as? MyDeleteTableViewCell else{
            return UITableViewCell()
        }

        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        cell.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cell.textLabel?.text = menus[indexPath.row].name
        return cell
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailUpdateFoodViewController()
        vc.configure(with: menus[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

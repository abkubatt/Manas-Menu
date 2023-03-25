//
//  DeleteFoodViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 17.03.23.
//

import UIKit

class DeleteFoodViewController: UIViewController {

    var items = ["Coca Cola", "Fanta", "Pepsi", "Kofte", "Pizza", "Yougurt","Coca Cola", "Fanta", "Pepsi", "Kofte", "Pizza", "Yougurt","Coca Cola", "Fanta", "Pepsi", "Kofte", "Pizza", "Yougurt",]
    
    var menuFoods = [Menu]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MyDeleteTableViewCell.self, forCellReuseIdentifier: MyDeleteTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Delete Food"
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
            APICaller.shared.getAllMenuFood { result in
                switch result {
                case .success(let menus):
                    self.menuFoods = menus
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
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


extension DeleteFoodViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuFoods.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyDeleteTableViewCell.identifier, for: indexPath) as? MyDeleteTableViewCell else{
            return UITableViewCell()
        }

        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        cell.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cell.textLabel?.text = menuFoods[indexPath.row].name
        return cell
    }


    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Handle deleting rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            print(indexPath.row)

            print(menuFoods)
            APICaller.shared.deleteMenuFood(with: menuFoods[indexPath.row].id) { result in
                switch result {
                case .success(let res):
                    _ = res
                    print(res)
                case .failure(let error):
//                    let error = error.localizedDescription
                    print("\(error.localizedDescription)")
                }
            }
            menuFoods.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)

            tableView.reloadData()
//            tableView.reloadData()

//            self.getMenus()
            print("--------------------------------------\(menuFoods)")
            tableView.endUpdates()

        }
    }
    
}

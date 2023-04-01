//
//  DeleteCanteenFoodsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 13.03.23.
//

import UIKit

class DeleteCanteenFoodsViewController: UIViewController {

    var canteenFoods = [Canteen]()
    var nameOfFood = ""
    var resultOfDeleting = true
    var baseURL = "http://192.168.242.250:8080/api/Canteens/"
    
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
        self.getCanteenFoods()
        view.addSubviews(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func getCanteenFoods(){
        DispatchQueue.main.async {
            APICaller.shared.getAllCanteenFoods { result in
                switch result {
                case .success(let canteens):
                    self.canteenFoods = canteens
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


extension DeleteCanteenFoodsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return canteenFoods.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyDeleteTableViewCell.identifier, for: indexPath) as? MyDeleteTableViewCell else{
            return UITableViewCell()
        }

        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        cell.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cell.textLabel?.text = canteenFoods[indexPath.row].name
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
            nameOfFood = canteenFoods[indexPath.row].name
            APICaller.shared.delete(with: "\(baseURL)\(canteenFoods[indexPath.row].id)") { result in
                switch result {
                case .success(_):
                    self.resultOfDeleting = true
                case .failure(let error):
                    _ = error.localizedDescription
                    self.resultOfDeleting = false
                }
            }
            canteenFoods.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            tableView.endUpdates()
            
        }
        if resultOfDeleting {
            let alertController = UIAlertController(title: "Success", message: "You successfully deleted: \(nameOfFood)", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            let when = DispatchTime.now() + 1.25
            DispatchQueue.main.asyncAfter(deadline: when){
              alertController.dismiss(animated: true, completion: nil)
            }
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Error while deleting: \(nameOfFood)", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            let when = DispatchTime.now() + 1.25
            DispatchQueue.main.asyncAfter(deadline: when){
              alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

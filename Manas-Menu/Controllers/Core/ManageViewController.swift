//
//  ManageViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 10.03.23.
//

import UIKit

class TitleForSection {
    var title: String?
    var icons: [UIImage]
    var rows: [String]
    
    init(title: String? = nil, icons: [UIImage], rows: [String]) {
        self.title = title
        self.icons = icons
        self.rows = rows
    }
}

class ManageViewController: UIViewController {

    
    var listChoice = [TitleForSection]()
    
    
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
        configureList()
        configureConstraints()

    }
    
    private func configureList(){
        listChoice.append(TitleForSection.init(title: "Manage Menu Food", icons: [UIImage(systemName: "fork.knife")!,UIImage(systemName: "square.and.pencil")!,UIImage(systemName: "trash")!], rows: ["Add Food", "Update Food", "Delete Food"]))
        listChoice.append(TitleForSection.init(title: "Manage Menu", icons: [ UIImage(systemName: "calendar.badge.plus")!,UIImage(systemName: "square.and.pencil")!,UIImage(systemName: "trash")!], rows: ["Add menu", "Update menu", "Delete menu"] ))
        listChoice.append(TitleForSection.init(title: "Manage Canteen", icons: [UIImage(systemName: "cup.and.saucer")!,UIImage(systemName: "square.and.pencil")!,UIImage(systemName: "trash")!],rows: ["Add canteen foods", "Update canteen foods", "Delete canteen foods"]))
        listChoice.append(TitleForSection.init(title: "Manage Free Foods", icons: [UIImage(systemName: "fork.knife")!,UIImage(systemName: "square.and.pencil")!,UIImage(systemName: "trash")!], rows: ["Add free foods", "Update free foods", "Delete free foods"]))
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listChoice.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listChoice[section].icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ManageListTableViewCell.identifier, for: indexPath) as? ManageListTableViewCell else{
            fatalError("The TableView could not dequeue a ManageListUITableViewCell in ManageViewController.")
        }
        
        let image = listChoice[indexPath.section].icons[indexPath.row]
        let title = listChoice[indexPath.section].rows[indexPath.row]
        cell.configure(with: image, and: title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selected = listChoice[indexPath.section].rows[indexPath.row]
        switch selected {
            case "Add Food":
            navigationController?.pushViewController(AddFoodViewController(), animated: true)
            
            case "Update Food":
            navigationController?.pushViewController(UpdateFoodViewController(), animated: true)
            
            case "Delete Food":
            navigationController?.pushViewController(DeleteFoodViewController(), animated: true)
            
            case "Add menu":
            navigationController?.pushViewController(AddMenuViewController(), animated: true)
            
            case "Update menu":
            navigationController?.pushViewController(UpdateMenuViewController(), animated: true)

            case "Delete menu":
            navigationController?.pushViewController(DeleteMenuViewController(), animated: true)
            
            case "Add canteen foods":
            navigationController?.pushViewController(AddCanteenFoodsViewController(), animated: true)

            case "Update canteen foods":
            navigationController?.pushViewController(UpdateCanteenFoodsViewController(), animated: true)

            case "Delete canteen foods":
            navigationController?.pushViewController(DeleteCanteenFoodsViewController(), animated: true)

            case "Add free foods":
            navigationController?.pushViewController(AddFreeFoodsViewController(), animated: true)

            case "Update free foods":
            navigationController?.pushViewController(UpdateFreeFoodsViewController(), animated: true)

            case "Delete free foods":
            navigationController?.pushViewController(DeleteFreeFoodsViewController(), animated: true)

            
        default:
            _ = "error"
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listChoice[section].title
    }
       
}


    
    

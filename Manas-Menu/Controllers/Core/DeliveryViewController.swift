//
//  DeliveryViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 06.04.23.
//

import UIKit


class DeliveryViewController: UIViewController {
    
    private let turkishTeaImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ttea")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let turkishTeaName: UILabel = {
        let label = UILabel()
        label.text = "Turkish Tea"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTurkishTea: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let turkishTeaCounter: UIStepper = {
        let step = UIStepper()
        step.value = 0
        step.minimumValue = 0
        step.maximumValue = 100
        step.translatesAutoresizingMaskIntoConstraints = false
        step.addTarget(self, action: #selector(updateCounter(sender:)), for: .valueChanged)
        return step
    }()
    
    override func viewDidLoad() {
        title = "Delivery"
        view.backgroundColor = .systemBackground
        view.addSubview(turkishTeaImage)
        view.addSubview(turkishTeaName)
        view.addSubview(amountTurkishTea)
        view.addSubview(turkishTeaCounter)
        
        configureConstraints()
    }
    
    @objc func updateCounter(sender: UIStepper) {
        amountTurkishTea.text = "\(Int(sender.value))"
        if sender.value != 0 {
            turkishTeaName.text = "Turkish Tea ✓"
        }else{
            turkishTeaName.text = "Turkish Tea"
        }
    }
    
    
    private func configureConstraints() {
        
        let turkishTeaImageConst = [
            turkishTeaImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            turkishTeaImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            turkishTeaImage.heightAnchor.constraint(equalToConstant: 90),
            turkishTeaImage.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let turkishTeaNameConst = [
            turkishTeaName.topAnchor.constraint(equalTo: turkishTeaImage.topAnchor, constant: 10),
            turkishTeaName.leadingAnchor.constraint(equalTo: turkishTeaImage.trailingAnchor, constant: 30),
        ]
        
        let amountTurkishTeaConst = [
            amountTurkishTea.topAnchor.constraint(equalTo: turkishTeaImage.bottomAnchor, constant: -35),
            amountTurkishTea.leadingAnchor.constraint(equalTo: turkishTeaImage.trailingAnchor, constant: 60)
        ]
        
        let turkishTeaCounterConst = [
            turkishTeaCounter.topAnchor.constraint(equalTo: turkishTeaName.bottomAnchor, constant: 20),
            turkishTeaCounter.leadingAnchor.constraint(equalTo: turkishTeaImage.trailingAnchor, constant: 130)
        ]
        
        NSLayoutConstraint.activate(turkishTeaImageConst)
        NSLayoutConstraint.activate(turkishTeaNameConst)
        NSLayoutConstraint.activate(amountTurkishTeaConst)
        NSLayoutConstraint.activate(turkishTeaCounterConst)
        
    }
}





















//class DeliveryViewController: UITableViewController {
//
//    var todoItems = [TodoItem](){
//        didSet{
//            print("to do items was set")
//            tableView.reloadData()
//        }
//    }
//
//    let reuseIdentifier = "TodoCell"
//
//    lazy var createNewButton: UIButton = {
//        let button = UIButton()
//        button.tintColor = UIColor(red: 208/255, green: 0/255, blue: 0/255, alpha: 1.0)
//        button.backgroundColor = UIColor(red: 96/255, green: 108/255, blue: 56/255, alpha: 1.0)
//        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
//        button.layer.zPosition  = CGFloat(Float.greatestFiniteMagnitude)
//        button.addTarget(self, action: #selector(createNewTodo), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Delivery"
//        view.backgroundColor = .systemBackground
//        configureTableView()
//        fetchItems()
//    }
//
//
//    @objc func createNewTodo() {
//        let vc = CreateTodoViewController()
//        present(vc, animated: true)
//    }
//
//    @objc func handleRefresh() {
//        self.tableView.refreshControl?.beginRefreshing()
//
//        if let isRefreshing = self.tableView.refreshControl?.isRefreshing,
//           isRefreshing {
//            DispatchQueue.main.async { [self]
//                self.fetchItems()
//                self.tableView.refreshControl?.endRefreshing()
//            }
//        }
//    }
//
//    private func fetchItems() {
//        PostService.shared.fetchAllItems { (allItems) in
//            self.todoItems = allItems
//        }
//    }
//
//
//    private func configureTableView() {
//        tableView.backgroundColor = .systemBackground
//
//        tableView.register(TodoCell.self, forCellReuseIdentifier: reuseIdentifier)
//        tableView.rowHeight = 75
//        tableView.separatorColor = .systemRed
//        tableView.separatorColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//        tableView.tableFooterView = UIView()
//
//        let refreshControl = UIRefreshControl()
//        refreshControl.tintColor = .white
//        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
//        tableView.refreshControl = refreshControl
//
//        tableView.addSubview(createNewButton)
//        createNewButton.anchor(bottom: tableView.safeAreaLayoutGuide.bottomAnchor, right: tableView.safeAreaLayoutGuide.rightAnchor, paddingBottom: 16, width: 56, height: 56 )
//        createNewButton.layer.cornerRadius = 56 / 2
//        createNewButton.alpha = 1
//
//    }
//
//}
//
//extension DeliveryViewController {
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoItems.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TodoCell else{
//            return UITableViewCell()
//        }
//        cell.todoItem = todoItems[indexPath.row]
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.fetchItems()
//        let todoItem = todoItems[indexPath.row]
//        print("------------\(todoItem)")
//        PostService.shared.updateItemStatus(todoid: todoItem.id, isComplete: true) { (error, ref) in
//            self.tableView.deselectRow(at: indexPath, animated: true)
//            self.fetchItems()
//        }
//    }
//
//
//}

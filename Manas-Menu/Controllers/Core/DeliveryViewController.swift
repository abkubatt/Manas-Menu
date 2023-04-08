//
//  DeliveryViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 06.04.23.
//

import UIKit
import FirebaseAuth

class DeliveryViewController: UIViewController {

    // - TURKISH TEA
    
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
        step.addTarget(self, action: #selector(updateTurkishTea(sender:)), for: .valueChanged)
        return step
    }()
    
    // - SIMPLE TEA
    
    private let sTeaImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "stea")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let sTeaName: UILabel = {
        let label = UILabel()
        label.text = "Shaking Tea"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sAmountTea: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let sTeaCounter: UIStepper = {
        let step = UIStepper()
        step.value = 0
        step.minimumValue = 0
        step.maximumValue = 100
        step.translatesAutoresizingMaskIntoConstraints = false
        step.addTarget(self, action: #selector(updateSimpleTea(sender:)), for: .valueChanged)
        return step
    }()
    
    // SIMPLE COFFE
    
    private let coffeeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "coffeep")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let coffeeName: UILabel = {
        let label = UILabel()
        label.text = "Coffee Plain"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coffeeAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let coffeeCounter: UIStepper = {
        let step = UIStepper()
        step.value = 0
        step.minimumValue = 0
        step.maximumValue = 100
        step.translatesAutoresizingMaskIntoConstraints = false
        step.addTarget(self, action: #selector(updateSimpleCoffee(sender:)), for: .valueChanged)
        return step
    }()
    
    // MILK COFFE
    
    private let coffeeMilkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "coffeem")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let coffeeMilkName: UILabel = {
        let label = UILabel()
        label.text = "Coffee with Milk"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coffeeMilkAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let coffeeMilkCounter: UIStepper = {
        let step = UIStepper()
        step.value = 0
        step.minimumValue = 0
        step.maximumValue = 100
        step.translatesAutoresizingMaskIntoConstraints = false
        step.addTarget(self, action: #selector(updateMilkCoffee(sender:)), for: .valueChanged)
        return step
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.setTitle(" ORDER ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(orderDrinks), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        title = "Delivery"
        view.backgroundColor = .systemBackground
        view.addSubview(turkishTeaImage)
        view.addSubview(turkishTeaName)
        view.addSubview(amountTurkishTea)
        view.addSubview(turkishTeaCounter)
        
        view.addSubview(sTeaImage)
        view.addSubview(sTeaName)
        view.addSubview(sAmountTea)
        view.addSubview(sTeaCounter)
        
        view.addSubview(coffeeImage)
        view.addSubview(coffeeName)
        view.addSubview(coffeeAmount)
        view.addSubview(coffeeCounter)
        
        view.addSubview(coffeeMilkImage)
        view.addSubview(coffeeMilkName)
        view.addSubview(coffeeMilkAmount)
        view.addSubview(coffeeMilkCounter)
        
        view.addSubview(orderButton)
        configureConstraints()
    }
    
    @objc func updateTurkishTea(sender: UIStepper) {
        amountTurkishTea.text = "\(Int(sender.value))"
        if sender.value != 0 {
            turkishTeaName.text = "Turkish Tea ✓"
        }else{
            turkishTeaName.text = "Turkish Tea"
        }
    }
    
    @objc func updateSimpleTea(sender: UIStepper) {
        sAmountTea.text = "\(Int(sender.value))"
        if sender.value != 0 {
            sTeaName.text = "Shaking Tea ✓"
        }else{
            sTeaName.text = "Shaking Tea"
        }
    }
    
    @objc func updateSimpleCoffee(sender: UIStepper) {
        coffeeAmount.text = "\(Int(sender.value))"
        if sender.value != 0 {
            coffeeName.text = "Coffee Plain ✓"
        }else{
            coffeeName.text = "Coffee Plain"
        }
    }
    
    @objc func updateMilkCoffee(sender: UIStepper) {
        coffeeMilkAmount.text = "\(Int(sender.value))"
        if sender.value != 0 {
            coffeeMilkName.text = "Coffee with Milk ✓"
        }else{
            coffeeMilkName.text = "Coffee with Milk"
        }
    }
    
    @objc func orderDrinks(){
        var message = ""
        if amountTurkishTea.text != "0" {
            message += "\(amountTurkishTea.text ?? "") "
            message += "Turkish Tea "
        }
        if sAmountTea.text != "0" {
            message += "\(sAmountTea.text ?? "") "
            message += "Shaking Tea "
        }
        if coffeeAmount.text != "0" {
            message += "\(coffeeAmount.text ?? "") "
            message += "Coffee Plain "
        }
        if coffeeMilkAmount.text != "0" {
            message += "\(coffeeMilkAmount.text ?? "") "
            message += "Coffee with Milk "
        }

        if message != "" {
            let currentUserEmail = Auth.auth().currentUser?.email
            
            guard let nameOfDrink = turkishTeaName.text else {return}
            let delivery = DrinksDelivery(id: 0, name: turkishTeaName.text ?? "", amount: amountTurkishTea.text ?? "", orderedPersonEmail: currentUserEmail ?? "", roomName: "BIL-543")
            PostService.shared.uploadTodoItem(delivery: delivery) { (error, ref) in
                self.amountTurkishTea.text = "0"
            }
            
            
            let alertController = UIAlertController(title: "Success", message: "You successfully ordered: \(message)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                print(#function)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Warning", message: "You do not choose an order", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                print(#function)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
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
        
        //----------------
        
        
        let sTeaImageConst = [
            sTeaImage.topAnchor.constraint(equalTo: turkishTeaImage.bottomAnchor, constant: 25),
            sTeaImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sTeaImage.heightAnchor.constraint(equalToConstant: 90),
            sTeaImage.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let sTeaNameConst = [
            sTeaName.topAnchor.constraint(equalTo: sTeaImage.topAnchor, constant: 10),
            sTeaName.leadingAnchor.constraint(equalTo: sTeaImage.trailingAnchor, constant: 30),
        ]
        
        let samountTeaConst = [
            sAmountTea.topAnchor.constraint(equalTo: sTeaImage.bottomAnchor, constant: -35),
            sAmountTea.leadingAnchor.constraint(equalTo: sTeaImage.trailingAnchor, constant: 60)
        ]
        
        let sTeaCounterConst = [
            sTeaCounter.topAnchor.constraint(equalTo: sTeaName.bottomAnchor, constant: 20),
            sTeaCounter.leadingAnchor.constraint(equalTo: sTeaImage.trailingAnchor, constant: 130)
        ]
        
        
        //----------------
        
        let coffeeImageConst = [
            coffeeImage.topAnchor.constraint(equalTo: sTeaImage.bottomAnchor, constant: 25),
            coffeeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            coffeeImage.heightAnchor.constraint(equalToConstant: 90),
            coffeeImage.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let coffeeNameConst = [
            coffeeName.topAnchor.constraint(equalTo: coffeeImage.topAnchor, constant: 10),
            coffeeName.leadingAnchor.constraint(equalTo: coffeeImage.trailingAnchor, constant: 30),
        ]
        
        let coffeeAmountConst = [
            coffeeAmount.topAnchor.constraint(equalTo: coffeeImage.bottomAnchor, constant: -35),
            coffeeAmount.leadingAnchor.constraint(equalTo: coffeeImage.trailingAnchor, constant: 60)
        ]
        
        let coffeeCounterConst = [
            coffeeCounter.topAnchor.constraint(equalTo: coffeeName.bottomAnchor, constant: 20),
            coffeeCounter.leadingAnchor.constraint(equalTo: coffeeImage.trailingAnchor, constant: 130)
        ]

        
        //----------------

        let coffeeMilkImageConst = [
            coffeeMilkImage.topAnchor.constraint(equalTo: coffeeImage.bottomAnchor, constant: 25),
            coffeeMilkImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            coffeeMilkImage.heightAnchor.constraint(equalToConstant: 90),
            coffeeMilkImage.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let coffeeMilkNameConst = [
            coffeeMilkName.topAnchor.constraint(equalTo: coffeeMilkImage.topAnchor, constant: 10),
            coffeeMilkName.leadingAnchor.constraint(equalTo: coffeeMilkImage.trailingAnchor, constant: 30),
        ]
        
        let coffeeMilkAmountConst = [
            coffeeMilkAmount.topAnchor.constraint(equalTo: coffeeMilkImage.bottomAnchor, constant: -35),
            coffeeMilkAmount.leadingAnchor.constraint(equalTo: coffeeMilkImage.trailingAnchor, constant: 60)
        ]
        
        let coffeeMilkCounterConst = [
            coffeeMilkCounter.topAnchor.constraint(equalTo: coffeeMilkName.bottomAnchor, constant: 20),
            coffeeMilkCounter.leadingAnchor.constraint(equalTo: coffeeMilkImage.trailingAnchor, constant: 130)
        ]
        
        //-------------
        
        let orderButtonConst = [
            orderButton.topAnchor.constraint(equalTo: coffeeMilkImage.bottomAnchor, constant: 70),
            orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ]
        
        NSLayoutConstraint.activate(turkishTeaImageConst)
        NSLayoutConstraint.activate(turkishTeaNameConst)
        NSLayoutConstraint.activate(amountTurkishTeaConst)
        NSLayoutConstraint.activate(turkishTeaCounterConst)
        
        NSLayoutConstraint.activate(sTeaImageConst)
        NSLayoutConstraint.activate(sTeaNameConst)
        NSLayoutConstraint.activate(samountTeaConst)
        NSLayoutConstraint.activate(sTeaCounterConst)
        
        NSLayoutConstraint.activate(coffeeImageConst)
        NSLayoutConstraint.activate(coffeeNameConst)
        NSLayoutConstraint.activate(coffeeAmountConst)
        NSLayoutConstraint.activate(coffeeCounterConst)
        
        NSLayoutConstraint.activate(coffeeMilkImageConst)
        NSLayoutConstraint.activate(coffeeMilkNameConst)
        NSLayoutConstraint.activate(coffeeMilkAmountConst)
        NSLayoutConstraint.activate(coffeeMilkCounterConst)
        
        NSLayoutConstraint.activate(orderButtonConst)
        
        
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

//
//  DetailUpdateMenuViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 15.03.23.
//

import UIKit


class DetailUpdateMenuViewController: UIViewController {
    
    var menusSoup = [Menu]()
    var menusWithMeat = [Menu]()
    var menusWithoutMeat = [Menu]()
    var menusDessert = [Menu]()
    var idOfMenu: Int = 0
    let baseURL = "http://192.168.241.114:8080/api/OneDayMenus/"
    let baseSoupUrl = "http://192.168.241.114:8080/api/Menus/GetSoups"
    let baseWithMeatUrl = "http://192.168.241.114:8080/api/Menus/GetWithMeat"
    let baseWithoutMeatUrl = "http://192.168.241.114:8080/api/Menus/GetWithoutMeat"
    let baseDessertMeatUrl = "http://192.168.241.114:8080/api/Menus/GetDesserts"
    var pic1 = 0
    var pic2 = 0
    var pic3 = 0
    var pic4 = 0
    var dateOfMenu = ""
    
    let dateForMenu: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.locale = Locale(identifier: "en_US")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle(" UPDATE ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.alpha = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
  
    let pickerView1: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let pickerView2: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let pickerView3: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let pickerView4: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update Menu"
        view.backgroundColor = .systemBackground
        self.getSoutMenus()
        self.getWithMeatMenus()
        self.getWithoutMeatMenus()
        self.getDessertMenus()
        view.addSubview(dateForMenu)
        view.addSubview(pickerView1)
        view.addSubview(pickerView2)
        view.addSubview(pickerView3)
        view.addSubview(pickerView4)
        view.addSubview(addButton)
        pickerView1.delegate = self
        pickerView1.dataSource = self

        pickerView2.delegate = self
        pickerView2.dataSource = self

        pickerView3.delegate = self
        pickerView3.dataSource = self

        pickerView4.delegate = self
        pickerView4.dataSource = self
        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        dateForMenu.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        title = "Add Menu"
        view.backgroundColor = .systemBackground
        self.getSoutMenus()
        self.getWithMeatMenus()
        self.getWithoutMeatMenus()
        self.getDessertMenus()
        view.addSubview(dateForMenu)
        view.addSubview(pickerView1)
        view.addSubview(pickerView2)
        view.addSubview(pickerView3)
        view.addSubview(pickerView4)
        view.addSubview(addButton)
        pickerView1.delegate = self
        pickerView1.dataSource = self

        pickerView2.delegate = self
        pickerView2.dataSource = self

        pickerView3.delegate = self
        pickerView3.dataSource = self

        pickerView4.delegate = self
        pickerView4.dataSource = self
        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        dateForMenu.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        configureConstraints()
    }
    
    func getSoutMenus(){
        DispatchQueue.main.async {
            APICaller.shared.getAllMenuFood(with: self.baseSoupUrl){ result in
                switch result {
                case .success(let menus):
                    self.menusSoup = menus
                case .failure(let error):
                    _ = error.localizedDescription
                }
                
            }
        }
    }
    
    func getWithMeatMenus(){
        DispatchQueue.main.async {
            APICaller.shared.getAllMenuFood (with: self.baseWithMeatUrl){ result in
                switch result {
                case .success(let menus):
                    self.menusWithMeat = menus
                case .failure(let error):
                    _ = error.localizedDescription
                }
                
            }
        }
    }
    
    func getWithoutMeatMenus(){
        DispatchQueue.main.async {
            APICaller.shared.getAllMenuFood (with: self.baseWithoutMeatUrl){ result in
                switch result {
                case .success(let menus):
                    self.menusWithoutMeat = menus
                case .failure(let error):
                    _ = error.localizedDescription
                }
                
            }
        }
    }
    
    func getDessertMenus(){
        DispatchQueue.main.async {
            APICaller.shared.getAllMenuFood (with: self.baseDessertMeatUrl){ result in
                switch result {
                case .success(let menus):
                    self.menusDessert = menus
                case .failure(let error):
                    _ = error.localizedDescription
                }
                
            }
        }
    }
    
    @objc private func addBtn(){
        pic1 = pic1 == 0 ? menusSoup[0].id : pic1
        pic2 = pic2 == 0 ? menusWithMeat[0].id : pic2
        pic3 = pic3 == 0 ? menusWithoutMeat[0].id : pic3
        pic4 = pic4 == 0 ? menusDessert[0].id : pic4
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let selectedDate = dateFormatter.string(from: Date())

        
        let saveMenuPerDay = MenuPerDay(id: idOfMenu, date: dateOfMenu == "" ? selectedDate : dateOfMenu, soupId: pic1, withMeetId: pic2, withoutMeetId: pic3, dessertId: pic4)
        
        APICaller.shared.updateMenuPerDay(url: URL(string: "\(baseURL)\(idOfMenu)")!, menu: saveMenuPerDay) { [weak self] response in
            
            DispatchQueue.main.async {
                switch response {
                case .success(_):
                    let alertController = UIAlertController(title: "Success", message: "You successfully update menu to: \(saveMenuPerDay.date)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self?.popBack(3)
                    }
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                   
                case.failure(_):
                    let alertController = UIAlertController(title: "Error", message: "Error while updating menu to: \(saveMenuPerDay.date)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self?.popBack(3)
                    }
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
 
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    private func configureConstraints() {
        let dateForMenuConstraints = [
            dateForMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateForMenu.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]

        let pickerView1Constraints = [
            pickerView1.topAnchor.constraint(equalTo: dateForMenu.bottomAnchor, constant: 15),
            pickerView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pickerView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pickerView1.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let pickerView2Constraints = [
            pickerView2.topAnchor.constraint(equalTo: pickerView1.bottomAnchor, constant: 12),
            pickerView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pickerView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pickerView2.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let pickerView3Constraints = [
            pickerView3.topAnchor.constraint(equalTo: pickerView2.bottomAnchor, constant: 12),
            pickerView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pickerView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pickerView3.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let pickerView4Constraints = [
            pickerView4.topAnchor.constraint(equalTo: pickerView3.bottomAnchor, constant: 12),
            pickerView4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pickerView4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pickerView4.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let addButtonConstraints = [
            addButton.topAnchor.constraint(equalTo: pickerView4.bottomAnchor, constant: 30),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(dateForMenuConstraints)
        NSLayoutConstraint.activate(pickerView1Constraints)
        NSLayoutConstraint.activate(pickerView2Constraints)
        NSLayoutConstraint.activate(pickerView3Constraints)
        NSLayoutConstraint.activate(pickerView4Constraints)
        NSLayoutConstraint.activate(addButtonConstraints)
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let selectedDate = dateFormatter.string(from: sender.date)
//        print("Selected date: \(selectedDate)")
        dateOfMenu = "\(selectedDate)"
    }
    
    public func configure(with idOfMenu: Int) {
        self.idOfMenu = idOfMenu
    }

}


extension DetailUpdateMenuViewController: UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate{
    
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//      // Filter the data based on the search query
//      let filteredData = // your filtering logic here
//
//      // Reload the picker view with the filtered data
//      pickerView1.reloadAllComponents()
//    }
    
    


    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            return menusSoup.count
            // Return the number of rows for pickerView1
        } else if pickerView == pickerView2 {
            return menusWithMeat.count
            // Return the number of rows for pickerView2
        } else if pickerView == pickerView3 {
            return menusWithoutMeat.count
            // Return the number of rows for pickerView3
        } else if pickerView == pickerView4 {
            return menusDessert.count
            // Return the number of rows for pickerView4
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return menusSoup[row].name
            // Return the title for the row in pickerView1
        } else if pickerView == pickerView2 {
            return menusWithMeat[row].name

            // Return the title for the row in pickerView2
        } else if pickerView == pickerView3 {
            return menusWithoutMeat[row].name

            // Return the title for the row in pickerView3
        } else if pickerView == pickerView4 {
            return menusDessert[row].name

            // Return the title for the row in pickerView4
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            pic1 = menusSoup[row].id
        } else if pickerView == pickerView2 {
            pic2 = menusWithMeat[row].id

        } else if pickerView == pickerView3 {
            pic3 = menusWithoutMeat[row].id
            // Handle the selection in pickerView3
        } else if pickerView == pickerView4 {
            pic4 = menusDessert[row].id
            // Handle the selection in pickerView4
        }
    }


}


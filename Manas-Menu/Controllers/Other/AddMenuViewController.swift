//
//  AddMenuViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 12.03.23.
//


import UIKit
import FirebaseFirestore


class AddMenuViewController: UIViewController {
    
    let desserts = ["Apple", "Banana", "Watermelon", "Kiwi", "Avocado", "Orange", "Mango", "Longan"]
    var adding = [String]()
    var pic1 = ""
    var pic2 = ""
    var pic3 = ""
    var pic4 = ""
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
        button.setTitle(" ADD MENU ", for: .normal)
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
        title = "Add Menu"
        view.backgroundColor = .systemBackground

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
    
    @objc private func addBtn(){
        adding.append(pic1 == "" ? desserts[0] : pic1)
        adding.append(pic2 == "" ? desserts[0] : pic2)
        adding.append(pic3 == "" ? desserts[0] : pic3)
        adding.append(pic4 == "" ? desserts[0] : pic4)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let selectedDate = dateFormatter.string(from: Date())
        adding.append(dateOfMenu == "" ? selectedDate : dateOfMenu)
        print(adding)
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
        print("Selected date: \(selectedDate)")
        dateOfMenu = "\(selectedDate)"
    }

}


extension AddMenuViewController: UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate{
    
    
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
            return desserts.count
            // Return the number of rows for pickerView1
        } else if pickerView == pickerView2 {
            return desserts.count
            // Return the number of rows for pickerView2
        } else if pickerView == pickerView3 {
            return desserts.count
            // Return the number of rows for pickerView3
        } else if pickerView == pickerView4 {
            return desserts.count
            // Return the number of rows for pickerView4
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return desserts[row]
            // Return the title for the row in pickerView1
        } else if pickerView == pickerView2 {
            return desserts[row]

            // Return the title for the row in pickerView2
        } else if pickerView == pickerView3 {
            return desserts[row]

            // Return the title for the row in pickerView3
        } else if pickerView == pickerView4 {
            return desserts[row]

            // Return the title for the row in pickerView4
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            pic1 = desserts[row]
        } else if pickerView == pickerView2 {
            pic2 = desserts[row]

        } else if pickerView == pickerView3 {
            pic3 = desserts[row]
            // Handle the selection in pickerView3
        } else if pickerView == pickerView4 {
            pic4 = desserts[row]
            // Handle the selection in pickerView4
        }
    }


}


//        "menus" {
//
//            "dateOfMenu": "20.03.2023",
//            "menu"{
//                "name": "Kavurma",
//                "calorie": "325",
//                "image": "url//image.jpg",
//                "type": "dessert"
//            }
//
//        }
    
    

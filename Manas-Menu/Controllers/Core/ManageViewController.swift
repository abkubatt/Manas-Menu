//
//  ManageViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 10.03.23.
//

import UIKit
import FirebaseFirestore


class ManageViewController: UIViewController {
    
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
    
    @objc private func addd(){
        print("add -------")
    }
 
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
        title = "Manage"
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
        addButton.addTarget(self, action: #selector(addd), for: .touchUpInside)

        dateForMenu.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        configureConstraints()
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
            addButton.topAnchor.constraint(equalTo: pickerView4.bottomAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 120)
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
        let selectedDate = dateFormatter.string(from: sender.date)
        print("Selected date: \(selectedDate)")
    }

}


extension ManageViewController: UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate{
    
    
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
            return 20
            // Return the number of rows for pickerView1
        } else if pickerView == pickerView2 {
            return 20
            // Return the number of rows for pickerView2
        } else if pickerView == pickerView3 {
            return 20
            // Return the number of rows for pickerView3
        } else if pickerView == pickerView4 {
            return 20
            // Return the number of rows for pickerView4
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return "Özbek Pilavı"
            // Return the title for the row in pickerView1
        } else if pickerView == pickerView2 {
            return "Etli Nohut"

            // Return the title for the row in pickerView2
        } else if pickerView == pickerView3 {
            return "Yeşil Mercimek Çorbası"

            // Return the title for the row in pickerView3
        } else if pickerView == pickerView4 {
            return "Islak Kek"

            // Return the title for the row in pickerView4
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
//            print(row)
            // Handle the selection in pickerView1
        } else if pickerView == pickerView2 {
            
            // Handle the selection in pickerView2
        } else if pickerView == pickerView3 {
            // Handle the selection in pickerView3
        } else if pickerView == pickerView4 {
//            print("4 \(row)")
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
    
    

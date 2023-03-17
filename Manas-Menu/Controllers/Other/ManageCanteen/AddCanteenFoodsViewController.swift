//
//  AddCanteenFoodsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 13.03.23.
//

import UIKit
import FirebaseFirestore


class AddCanteenFoodsViewController: UIViewController {
    
    let desserts = ["Apple", "Banana", "Watermelon", "Kiwi", "Avocado", "Orange", "Mango", "Longan"]
    let canteedCategories = ["DRINKS", "PIZZA AND PIDES", "BAKERY PRODUCTS", "DESSERTS", "OTHER FOODS"]
    var adding = [String]()
    var pic1 = ""
    var pic2 = ""
    var pic3 = ""
    var price: Int = 0
    var dateOfMenu = ""
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle(" ADD ", for: .normal)
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
    
    let priceField: UITextField = {
        let field = UITextField()
        field.placeholder = "Price"
        field.backgroundColor = .textFieldCustomColor
        field.layer.cornerRadius = 6
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Canteen Foods"
        view.backgroundColor = .systemBackground

        view.addSubview(pickerView1)
        view.addSubview(pickerView2)
        view.addSubview(pickerView3)
        view.addSubview(priceField)
        view.addSubview(addButton)
        pickerView1.delegate = self
        pickerView1.dataSource = self

        pickerView2.delegate = self
        pickerView2.dataSource = self

        pickerView3.delegate = self
        pickerView3.dataSource = self

        priceField.delegate = self
        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc private func addBtn(){
        adding.append(pic1 == "" ? desserts[0] : pic1)
        adding.append(pic2 == "" ? desserts[0] : pic2)
        adding.append(pic3 == "" ? canteedCategories[0] : pic3)
        print(price == 1 ? 1 : price)

        print(adding)
    }
 
    
    private func configureConstraints() {

        let pickerView1Constraints = [
            pickerView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
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
        
        let priceFieldConstraints = [
            priceField.topAnchor.constraint(equalTo: pickerView3.bottomAnchor, constant: 25),
            priceField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceField.heightAnchor.constraint(equalToConstant: 30),
            priceField.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let addButtonConstraints = [
            addButton.topAnchor.constraint(equalTo: priceField.bottomAnchor, constant: 30),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(pickerView1Constraints)
        NSLayoutConstraint.activate(pickerView2Constraints)
        NSLayoutConstraint.activate(pickerView3Constraints)
        NSLayoutConstraint.activate(priceFieldConstraints)
        NSLayoutConstraint.activate(addButtonConstraints)
    }


}


extension AddCanteenFoodsViewController: UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate, UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            price = Int(text) ?? 1
        }else{
            price = 1
        }
    }
    
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
            return canteedCategories[row]

            // Return the title for the row in pickerView3
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            pic1 = desserts[row]
        } else if pickerView == pickerView2 {
            pic2 = desserts[row]

        } else if pickerView == pickerView3 {
            pic3 = canteedCategories[row]
            // Handle the selection in pickerView3
        }
    }


}


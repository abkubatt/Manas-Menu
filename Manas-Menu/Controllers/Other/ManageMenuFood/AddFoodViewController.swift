//
//  AddFoodViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 17.03.23.
//

import UIKit

class AddFoodViewController: UIViewController {
    
    let desserts = ["Apple", "Banana", "Watermelon", "Kiwi", "Avocado", "Orange", "Mango", "Longan"]
    let canteedCategories = ["DRINKS", "PIZZA AND PIDES", "BAKERY PRODUCTS", "DESSERTS", "OTHER FOODS"]
    var adding = [String?]()
    
    var nameField: String?
    var calorieField: String?
    var imageField: String?
    var categoryFood = ""
    
    
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
    
  
    let nameUIField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.backgroundColor = .textFieldCustomColor
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let calorieUIField: UITextField = {
        let field = UITextField()
        field.placeholder = "Calorie"
        field.backgroundColor = .textFieldCustomColor
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let imageUIField: UITextField = {
        let field = UITextField()
        field.placeholder = "Image"
        field.backgroundColor = .textFieldCustomColor
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Food"
        view.backgroundColor = .systemBackground

        view.addSubviews(nameUIField)
        view.addSubviews(calorieUIField)
        view.addSubviews(imageUIField)
        view.addSubviews(categoryPicker)
        view.addSubview(addButton)
        
        nameUIField.delegate = self
        calorieUIField.delegate = self
        imageUIField.delegate = self
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self

        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc private func addBtn(){
        adding.append(nameField)
        adding.append(calorieField)
        adding.append(imageField)
        adding.append(categoryFood == "" ? canteedCategories[0] : categoryFood)
        print(adding)
    }
 
    
    private func configureConstraints() {
        
        let textField1Constraints = [
            nameUIField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameUIField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameUIField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameUIField.heightAnchor.constraint(equalToConstant: 35)
            
        ]
        
        let textField2Constraints = [
            calorieUIField.topAnchor.constraint(equalTo: nameUIField.bottomAnchor, constant: 40),
            calorieUIField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            calorieUIField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            calorieUIField.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let textField3Constraints = [
            imageUIField.topAnchor.constraint(equalTo: calorieUIField.bottomAnchor, constant: 40),
            imageUIField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            imageUIField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            imageUIField.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let categoryPickerConstraints = [
            categoryPicker.topAnchor.constraint(equalTo: imageUIField.bottomAnchor, constant: 35),
            categoryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            categoryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            categoryPicker.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        
        let addButtonConstraints = [
            addButton.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 30),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(textField1Constraints)
        NSLayoutConstraint.activate(textField2Constraints)
        NSLayoutConstraint.activate(textField3Constraints)
        NSLayoutConstraint.activate(categoryPickerConstraints)
        NSLayoutConstraint.activate(addButtonConstraints)
    }


}


extension AddFoodViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameUIField {
            nameField = textField.text
        }else if textField == calorieUIField {
            calorieField = textField.text
        }else if textField == imageUIField {
            imageField = textField.text
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return canteedCategories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return canteedCategories[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            categoryFood = canteedCategories[row]
        

    }


}


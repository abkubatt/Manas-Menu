//
//  DetailUpdateFoodViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 17.03.23.
//

import UIKit

class DetailUpdateFoodViewController: UIViewController {
    
    let desserts = ["Apple", "Banana", "Watermelon", "Kiwi", "Avocado", "Orange", "Mango", "Longan"]
    let canteedCategories = ["DRINKS", "PIZZA AND PIDES", "BAKERY PRODUCTS", "DESSERTS", "OTHER FOODS"]
    var adding = [String]()
    var categoryFood = ""
    var amount = 1
    var pic3 = ""
    var pic4 = ""
    var dateOfMenu = ""
    var idOfMenu: Int = 0
    
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
    
  
    let textField1: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.text = "1"
        field.backgroundColor = .secondaryLabel
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let textField2: UITextField = {
        let field = UITextField()
        field.placeholder = "Calorie"
        field.text = "1"
        field.backgroundColor = .secondaryLabel
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let textField3: UITextField = {
        let field = UITextField()
        field.placeholder = "Image"
        field.text = "1"
        field.backgroundColor = .secondaryLabel
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
        title = "Update Food"
        view.backgroundColor = .systemBackground

        view.addSubviews(textField1)
        view.addSubviews(textField2)
        view.addSubviews(textField3)
        view.addSubviews(categoryPicker)
        view.addSubview(addButton)
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self

        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc private func addBtn(){
        adding.append(categoryFood == "" ? canteedCategories[0] : categoryFood)
//        adding.append(amount)
        print(amount)
        print(adding)
    }
 
    
    private func configureConstraints() {
        
        let textField1Constraints = [
            textField1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textField1.heightAnchor.constraint(equalToConstant: 35)
            
        ]
        
        let textField2Constraints = [
            textField2.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 40),
            textField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textField2.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let textField3Constraints = [
            textField3.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 40),
            textField3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textField3.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let categoryPickerConstraints = [
            categoryPicker.topAnchor.constraint(equalTo: textField3.bottomAnchor, constant: 35),
            categoryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            categoryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
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
    
    
    public func configure(with idOfMenu: Int) {
        self.idOfMenu = idOfMenu
        print(self.idOfMenu)
    }

}


extension DetailUpdateFoodViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            amount = Int(text) ?? 1
        }else{
            amount = 1
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

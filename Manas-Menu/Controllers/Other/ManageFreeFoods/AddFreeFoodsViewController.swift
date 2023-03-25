//
//  AddFreeFoodsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 13.03.23.
//

import UIKit
import FirebaseFirestore


class AddFreeFoodsViewController: UIViewController {
    
    let desserts = ["Apple", "Banana", "Watermelon", "Kiwi", "Avocado", "Orange", "Mango", "Longan"]
    let canteedCategories = ["DRINKS", "PIZZA AND PIDES", "BAKERY PRODUCTS", "DESSERTS", "OTHER FOODS"]
    var adding = [String]()
    var pic1 = ""
    var amount = 1
    var pic3 = ""
    var pic4 = ""
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
    
    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Amount"
        field.backgroundColor = .textFieldCustomColor
        field.layer.cornerRadius = 6
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Free Foods"
        view.backgroundColor = .systemBackground

        view.addSubview(pickerView1)
        view.addSubviews(textField)
        view.addSubview(addButton)
        pickerView1.delegate = self
        pickerView1.dataSource = self
        textField.delegate = self

        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc private func addBtn(){
        adding.append(pic1 == "" ? desserts[0] : pic1)
//        adding.append(amount)
//        print(amount)
//        print(adding)
    }
 
    
    private func configureConstraints() {

        let pickerView1Constraints = [
            pickerView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pickerView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pickerView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pickerView1.heightAnchor.constraint(equalToConstant: 130)
        ]
        
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: pickerView1.bottomAnchor, constant: 25),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let addButtonConstraints = [
            addButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(pickerView1Constraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(addButtonConstraints)
    }


}


extension AddFreeFoodsViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
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
        if pickerView == pickerView1 {
            return desserts.count
            // Return the number of rows for pickerView1
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return desserts[row]
            // Return the title for the row in pickerView1
        }

            // Return the title for the row in pickerView2
        
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            pic1 = desserts[row]
        }
    }


}

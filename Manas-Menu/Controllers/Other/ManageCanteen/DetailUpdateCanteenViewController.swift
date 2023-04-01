//
//  DetailUpdateCanteenViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 15.03.23.
//


import UIKit


class DetailUpdateCanteenFoodsViewController: UIViewController {
    
    let canteedCategories = ["DRINKS", "PIZZA AND PIDES", "BAKERY PRODUCTS", "DESSERTS", "OTHER FOODS"]
    var adding = [String]()
    var nameF = ""
    var imageF = ""
    var pic3 = ""
    var price: Int = 0
    var dateOfMenu = ""
    var idOfCanteenFood: Int = 0
    let baseURL = "http://192.168.242.250:8080/api/Canteens/"

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
    
    let nameUIField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
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
        title = "Update Canteen Foods"
        view.backgroundColor = .systemBackground

        view.addSubview(nameUIField)
        view.addSubview(imageUIField)
        view.addSubview(pickerView3)
        view.addSubview(priceField)
        view.addSubview(addButton)
        nameUIField.delegate = self
        imageUIField.delegate = self

        pickerView3.delegate = self
        pickerView3.dataSource = self

        priceField.delegate = self
        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc private func addBtn(){

        pic3 = pic3 == "" ? canteedCategories[0] : pic3
        
        let saveCanteenFood = Canteen(id: idOfCanteenFood, name: nameF, type: pic3, price: price, image: imageF, amountForFree: 0)
        
        APICaller.shared.updateCanteenFood(url: URL(string: "\(baseURL)\(idOfCanteenFood)")!, canteen: saveCanteenFood) { [weak self] response in
            DispatchQueue.main.async {
                switch response {
                case .success(_):
                    let alertController = UIAlertController(title: "Success", message: "You successfully update canteen food: \(saveCanteenFood.name)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self?.popBack(3)
                    }
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                   
                case.failure(_):
                    let alertController = UIAlertController(title: "Error", message: "Error while updating canteen food: \(saveCanteenFood.name)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self?.popBack(3)
                    }
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
 
    
    private func configureConstraints() {

        let textField1Constraints = [
            nameUIField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameUIField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameUIField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameUIField.heightAnchor.constraint(equalToConstant: 35)
            
        ]
        
        let textField2Constraints = [
            imageUIField.topAnchor.constraint(equalTo: nameUIField.bottomAnchor, constant: 40),
            imageUIField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            imageUIField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            imageUIField.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let pickerView3Constraints = [
            pickerView3.topAnchor.constraint(equalTo: imageUIField.bottomAnchor, constant: 35),
            pickerView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            pickerView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
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
        
        NSLayoutConstraint.activate(textField1Constraints)
        NSLayoutConstraint.activate(textField2Constraints)
        NSLayoutConstraint.activate(pickerView3Constraints)
        NSLayoutConstraint.activate(priceFieldConstraints)
        NSLayoutConstraint.activate(addButtonConstraints)
    }
    
    public func configure(with idOfCanteenFood: Int) {
        self.idOfCanteenFood = idOfCanteenFood
    }
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }


}


extension DetailUpdateCanteenFoodsViewController: UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate, UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameUIField {
            nameF = nameUIField.text ?? ""
        }else if textField == imageUIField {
            imageF = imageUIField.text ?? ""
        }else if textField == priceField{
            if let text = priceField.text {
                price = Int(text) ?? 1
            }else{
                price = 1
            }
        }
    }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == pickerView3 {
                return canteedCategories.count
            }
            return 0
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == pickerView3 {
                return canteedCategories[row]
            }
            return nil
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView == pickerView3 {
                pic3 = canteedCategories[row]
                // Handle the selection in pickerView3
            }
        }
}

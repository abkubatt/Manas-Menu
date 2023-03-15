//
//  DetailUpdateCanteenViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 15.03.23.
//


import UIKit


class DetailUpdateCanteenFoodsViewController: UIViewController {
    
    let desserts = ["Apple", "Banana", "Watermelon", "Kiwi", "Avocado", "Orange", "Mango", "Longan"]
    let canteedCategories = ["DRINKS", "PIZZA AND PIDES", "BAKERY PRODUCTS", "DESSERTS", "OTHER FOODS"]
    var adding = [String]()
    var pic1 = ""
    var pic2 = ""
    var pic3 = ""
    var pic4 = ""
    var dateOfMenu = ""
    
    var idOfCanteenFood: Int = 0
    
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
        title = "Update Canteen Foods"
        view.backgroundColor = .systemBackground

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
        
        configureConstraints()
    }
    
    @objc private func addBtn(){
        adding.append(pic1 == "" ? desserts[0] : pic1)
        adding.append(pic2 == "" ? desserts[0] : pic2)
        adding.append(pic3 == "" ? desserts[0] : pic3)
        adding.append(pic4 == "" ? canteedCategories[0] : pic4)

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
        
        NSLayoutConstraint.activate(pickerView1Constraints)
        NSLayoutConstraint.activate(pickerView2Constraints)
        NSLayoutConstraint.activate(pickerView3Constraints)
        NSLayoutConstraint.activate(pickerView4Constraints)
        NSLayoutConstraint.activate(addButtonConstraints)
    }
    
    public func configure(with idOfCanteenFood: Int) {
        self.idOfCanteenFood = idOfCanteenFood
        print(self.idOfCanteenFood)
    }


}


extension DetailUpdateCanteenFoodsViewController: UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate{
    
    
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
            return canteedCategories.count
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
            return canteedCategories[row]

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
            pic4 = canteedCategories[row]
            // Handle the selection in pickerView4
        }
    }


}

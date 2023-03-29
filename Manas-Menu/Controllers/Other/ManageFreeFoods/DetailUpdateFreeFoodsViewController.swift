//
//  DetailUpdateFreeFoodsViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 15.03.23.
//

import UIKit


class DetailUpdateFreeFoodsViewController: UIViewController {

    var freeConteenFood = [Canteen]()
    
    var adding = [String]()
    var toUpdateFreeFood: Canteen?
    var idOdFreeFood = 0
    var idOfFreeFood: Int = 0
    var nameOfFreeFood = ""
    var amountOfFreeFood: Int = 0
    
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
    
    let counter: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 1000
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(updateCounter(sender:)), for: .valueChanged)
        return stepper
    }()
    
    let counterValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Free Foods"
        view.backgroundColor = .systemBackground
        view.addSubview(pickerView1)
        view.addSubviews(counter)
        view.addSubviews(counterValue)
        view.addSubview(addButton)
        pickerView1.delegate = self
        pickerView1.dataSource = self
//        textField.delegate = self

        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        title = "Update Free Foods"
        view.backgroundColor = .systemBackground
        view.addSubview(pickerView1)
        view.addSubviews(counter)
        view.addSubview(addButton)
        pickerView1.delegate = self
        pickerView1.dataSource = self

        addButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc func updateCounter(sender: UIStepper) {
        counterValue.text = "\(Int(counter.value))"
        toUpdateFreeFood?.amountForFree = Int(sender.value)
        if Int(sender.value) == 0 {
            addButton.setTitle(" DELETE ", for: .normal)
            addButton.backgroundColor = .red
        }else{
            addButton.setTitle(" UPDATE ", for: .normal)
            addButton.backgroundColor = .blue
        }
    }
    
    
    @objc private func addBtn(){
            
        toUpdateFreeFood = toUpdateFreeFood == nil ? freeConteenFood[0] : toUpdateFreeFood
                
        guard let freeFood = toUpdateFreeFood else{
            _ = "Free food is empty \(String(describing: toUpdateFreeFood))"
            return
        }
        
        APICaller.shared.updateFreeFood(canteen: freeFood, id: freeFood.id, amount: freeFood.amountForFree) { [weak self] response in
            DispatchQueue.main.async {
                switch response {
                case .success(_):
                    let alertController = UIAlertController(title: "Success", message: "You successfully update free food: \(freeFood.name)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        self?.popBack(3)
                    }
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                   
                case.failure(_):
                    let alertController = UIAlertController(title: "Error", message: "Error while updating free food: \(freeFood.name)", preferredStyle: .alert)
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

        let pickerView1Constraints = [
            pickerView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pickerView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pickerView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pickerView1.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let counterValueConstraints = [
            counterValue.topAnchor.constraint(equalTo: pickerView1.bottomAnchor, constant: 30),
            counterValue.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let counterConstraints = [
            counter.topAnchor.constraint(equalTo: counterValue.bottomAnchor, constant: 20),
            counter.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let addButtonConstraints = [
            addButton.topAnchor.constraint(equalTo: counter.bottomAnchor, constant: 60),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(pickerView1Constraints)
        NSLayoutConstraint.activate(counterValueConstraints)
        NSLayoutConstraint.activate(counterConstraints)
        NSLayoutConstraint.activate(addButtonConstraints)
    }
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    
    public func configure(with freeFood: Canteen) {
        toUpdateFreeFood = freeFood
        self.idOfFreeFood = freeFood.id
        self.nameOfFreeFood = freeFood.name
        self.counterValue.text = "\(freeFood.amountForFree)"
    }

}


extension DetailUpdateFreeFoodsViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            return 1
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return nameOfFreeFood
        }
        return nil
    }

}

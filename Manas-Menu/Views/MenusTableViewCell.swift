//
//  MenusTableViewCell.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 03.04.23.
//

import UIKit

class MenusTableViewCell: UITableViewCell {

    static let identifier = "MenusTableViewCell"
    
    
    private let countOfFoodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let amountOfFoodLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Calorie:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountOfFoodLabel)
        contentView.addSubview(countOfFoodLabel)
        contentView.addSubview(titlesPosterUIImageView)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        let titlesPosterUIImageViewConstraints = [
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 110),
            titlesPosterUIImageView.heightAnchor.constraint(equalToConstant: 110)
        ]
        
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -14)
        ]
        
        let amountOfFoodLabelConstraints = [
            amountOfFoodLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            amountOfFoodLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 15)
        ]
        
        let countOfFoodLabelConstraints = [
            countOfFoodLabel.leadingAnchor.constraint(equalTo: amountOfFoodLabel.trailingAnchor, constant: 8),
            countOfFoodLabel.centerYAnchor.constraint(equalTo: amountOfFoodLabel.centerYAnchor)
        ]
        

        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(amountOfFoodLabelConstraints)
        NSLayoutConstraint.activate(countOfFoodLabelConstraints)
    }
    
    
    public func configure(with model: MenusViewModel){
        
        guard let url = URL(string: "\(model.posterURL)") else {
            return
        }
        
        titlesPosterUIImageView.sd_setImage(with: url)
        titleLabel.text = model.titleName
        countOfFoodLabel.text = "\(model.calorie)"
    }
      

}

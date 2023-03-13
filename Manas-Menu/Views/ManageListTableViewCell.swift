//
//  ManageListTableViewCell.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 13.03.23.
//

import UIKit

class ManageListTableViewCell: UITableViewCell {

    static let identifier = "ManageListTableViewCell"
    
    private let iconOfTitle: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "questionmark")
        image.tintColor = .label
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titles: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Error"
        return label
    }()
    
    private let rightArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .secondaryLabel
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder")
    }
    
    public func configure(with image: UIImage, and title: String) {
        iconOfTitle.image = image
        titles.text = title
    }
    
    private func setupUI() {
        
        contentView.addSubview(iconOfTitle)
        contentView.addSubview(titles)
        contentView.addSubview(rightArrow)
        
        configureConstraints()
        
    }
    
    private func configureConstraints(){
        
        let myimageConstraints = [
            iconOfTitle.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            iconOfTitle.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            iconOfTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            iconOfTitle.widthAnchor.constraint(equalToConstant: 20)
        ]
        
        let mylabelConstraints = [
            titles.leadingAnchor.constraint(equalTo: iconOfTitle.trailingAnchor, constant: 16),
            titles.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            titles.topAnchor.constraint(equalTo: contentView.topAnchor),
            titles.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        let rightArrowConstraints = [
            rightArrow.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            rightArrow.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            rightArrow.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(myimageConstraints)
        NSLayoutConstraint.activate(mylabelConstraints)
        NSLayoutConstraint.activate(rightArrowConstraints)
        
        
    }

}

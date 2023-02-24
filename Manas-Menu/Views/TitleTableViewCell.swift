//
//  TitleTableViewCell.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 24.02.23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    
//    private let playTitleButton: UIButton = {
//        let button = UIButton()
//        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
//        button.setImage(image, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .systemRed
//
//        return button
//    }()
    
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
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
//        contentView.addSubview(playTitleButton)
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
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
//
//        let playTitleButtonConstraints = [
//            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
//        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    
    public func configure(with model: TitleViewModel){
        
        guard let url = URL(string: "\(model.posterURL)") else {
            return
        }
        
        titlesPosterUIImageView.sd_setImage(with: url)
        titleLabel.text = model.titleName
    }
      

}

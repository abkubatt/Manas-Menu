//
//  TodoCell.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 07.04.23.
//
import UIKit

class TodoCell: UITableViewCell {
    
    var todoItem: TodoItem? {
        didSet{
            titleLabel.text = todoItem?.title ?? ""
            
            if let isComplete = todoItem?.isComplete, isComplete {
                statusLabel.text = "Status: Complete"
                statusLabel.textColor = UIColor(red: 96/255, green: 108/255, blue: 56/255, alpha: 1.0)
            }else{
                statusLabel.text = "Status: InComplete"
                statusLabel.textColor = UIColor(red: 208/255, green: 0/255, blue: 0/255, alpha: 1.0)
            }
        }
    }
    
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.text = "Title label"
        return label
    }()
    
    private let statusLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Status: Incomplete"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 252/255, green: 163/255, blue: 17/255, alpha: 1.0)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        addSubview(statusLabel)
        statusLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init error")
    }
    
    
    
    
}

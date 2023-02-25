//
//  RMFooterLoadingCollectionReusableView.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 05.02.23.
//

import UIKit

//class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
//    static let identifier = "RMFooterLoadingCollectionReusableView"
//
//    private let spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .large)
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.isHidden = true
//        return spinner
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .systemBackground
//        addSubview(spinner)
//        addConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("Unsupported")
//    }
//
//    private func addConstraints(){
//        NSLayoutConstraint.activate([
//            spinner.widthAnchor.constraint(equalToConstant: 100),
//            spinner.heightAnchor.constraint(equalToConstant: 100),
//            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
//            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
//    }
//
//    public func startAnimating() {
//        spinner.startAnimating()
//    }
//}
//

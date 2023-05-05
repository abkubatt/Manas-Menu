//
//  CarouselLayout.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 29.01.23.
//

import UIKit

final class CarouselLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
        self.scrollDirection = .horizontal
        self.sectionInset = .zero
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        if let collectionView = collectionView {
            itemSize = collectionView.frame.size
        }
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard itemSize != newBounds.size else { return false }
        itemSize = newBounds.size
        return true
    }
    
    
}

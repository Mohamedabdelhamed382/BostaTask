//
//  CollectionCell+ Extension.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCellNib<Cell: UICollectionViewCell>(cellClass: Cell.Type){
        self.register(UINib(nibName: cellClass.identifier, bundle: nil), forCellWithReuseIdentifier: cellClass.identifier)
    }
    
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell{
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    func setBackGroundView(type: NotFoundType?){
        let notFoundView = NotFoundView(type: type)
        self.backgroundView = notFoundView
    }
}

extension UICollectionViewCell {

    class var identifier: String {
        return String(describing: self)
    }
    
}


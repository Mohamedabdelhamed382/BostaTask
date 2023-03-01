//
//  AlbumsCollectionViewCell.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumPhoto: UIImageView!
    
    func setup(url: String) {
        albumPhoto.setImageFromStringrURL(photo: albumPhoto, stringUrl: url)
    }
    
    
}

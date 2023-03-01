//
//  AlbumPhotoDetailsViewModel.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation

class AlbumPhotoDetailsViewModel: BaseViewModel {
    
    let photoAlbum:PhotoAlbum?
    
    init(photoAlbum:PhotoAlbum) {
        self.photoAlbum = photoAlbum
        super.init()
    }
    
    
}

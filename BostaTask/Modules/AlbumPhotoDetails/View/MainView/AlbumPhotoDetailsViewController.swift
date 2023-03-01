//
//  AlbumPhotoDetailsViewController.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumPhotoDetailsViewController: BaseWireFrame<AlbumPhotoDetailsViewModel> {
    
    @IBOutlet weak var uiSharingIcon: UIButton!
    @IBOutlet weak var uiPostPhoto: UIImageView!
    @IBOutlet weak var uiTitleImage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album Details"
        uiPostPhoto.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture))
        uiPostPhoto.addGestureRecognizer(pinchGesture)
      
    }
    
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
            
        } else if sender.state == .ended {
           self.uiPostPhoto.transform = CGAffineTransform.identity
        }
       
    }
    
    override func bind(viewModel: AlbumPhotoDetailsViewModel) {
      
        uiPostPhoto.setImageFromStringrURL(photo: uiPostPhoto, stringUrl: viewModel.photoAlbum?.url ?? "")
        uiTitleImage.text = viewModel.photoAlbum?.title
        uiSharingIcon.rx.tap.subscribe { [weak self]_ in
            guard let image = self?.uiPostPhoto?.image, let url = URL(string: (viewModel.photoAlbum?.url!)!) else { return }
                    let data = [image, url] as [Any]
                    UIApplication.share(data)
        }.disposed(by: disposeBag)
    }
    
    
}

//
//  AlbumsViewController.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumsViewController: BaseWireFrame<AlbumsViewModel> {
    @IBOutlet weak var uiTitleLbl: UILabel!
    @IBOutlet weak var uiPhotosCollectionView: UICollectionView! {
        didSet{
            uiPhotosCollectionView.registerCellNib(cellClass: AlbumsCollectionViewCell.self)
        }
    }
    @IBOutlet weak var uiSearchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Albums"
        uiSearchTextField.delegate = self
    }
    
    override func bind(viewModel: AlbumsViewModel) {
        uiTitleLbl.text = viewModel.album?.title
        bindWithCollectionView()
        bindModelSelected()
        
        self.viewModel.isDataOfSeachExist.subscribe { [weak self] isExist in
            guard let isExist = isExist.element else {return}
            if isExist {
                self?.uiPhotosCollectionView.setBackGroundView(type: .searchNotFound)
            } else {
                self?.uiPhotosCollectionView.setBackGroundView(type: .none)
            }
        }.disposed(by: disposeBag)
    }
    
    func bindToSearchValue() {
        uiSearchTextField.rx.text
            .bind(to: viewModel.searchValueBehavior)
            .disposed(by: disposeBag)
    }


}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private func bindWithCollectionView() {
        uiPhotosCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.photoAlbumsSubjects.bind(to: uiPhotosCollectionView.rx.items(cellIdentifier: AlbumsCollectionViewCell.identifier,cellType: AlbumsCollectionViewCell.self)) { [weak self](row,model, cell) in
            guard self != nil else {return}
            guard let url = model.url else {return}
            cell.setup(url: url)
        }.disposed(by: disposeBag)
    }
    
    private func bindModelSelected() {
        uiPhotosCollectionView.rx.modelSelected(PhotoAlbum.self).subscribe { [weak self] model in
            guard self != nil else {return}
            let albumsPhotoDetailsViewModel = AlbumPhotoDetailsViewModel(photoAlbum: model)
            let albumsPhotoDetailsViewController = AlbumPhotoDetailsViewController(viewModel: albumsPhotoDetailsViewModel)
            self?.navigationController?.pushViewController(albumsPhotoDetailsViewController, animated: true)
        }.disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (self.view.frame.size.width/3), height: (self.view.frame.size.width/3))
    }
}

extension AlbumsViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchAction), object: nil)
        perform(#selector(searchAction), with: nil, afterDelay: 2)
    }
    
    @objc func searchAction() {
        bindToSearchValue()
    }
}

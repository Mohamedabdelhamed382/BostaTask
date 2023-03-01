//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 28/02/2023.
//

import UIKit
import RxSwift
import RxCocoa


class ProfileViewController: BaseWireFrame<ProfileViewModel> {
    
    @IBOutlet weak var uiUserNameLbl: UILabel!
    @IBOutlet weak var uiUserAddressLbl: UILabel!
    @IBOutlet weak var uiAlbumsTableView: UITableView!{
        didSet{
            uiAlbumsTableView.registerCellNib(cellClass: uiAlbumsTableViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        uiAlbumsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func bind(viewModel: ProfileViewModel) {
        subscribeToSubjectsViewModel()
        bindWithAlbumsTableView()
        bindModelSelected()
    }
    
    func subscribeToSubjectsViewModel() {
        
        self.viewModel.usersResponse.subscribe { [weak self] usersResponseElement in
            guard let self = self else {return}
            guard let usersResponseElement = usersResponseElement.element else {return}
            guard let address = usersResponseElement.address else {return}
            self.uiUserNameLbl.text = usersResponseElement.name
            let usersAddress =  "\(address.street ?? ""),\(address.city ?? ""),\(address.suite ?? ""),\(address.zipcode ?? "")"
            self.uiUserAddressLbl.text = usersAddress
        }.disposed(by: disposeBag)
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    private func bindWithAlbumsTableView() {
        uiAlbumsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.albumsResponse.bind(to: uiAlbumsTableView.rx.items(cellIdentifier: uiAlbumsTableViewCell.identifier,cellType: uiAlbumsTableViewCell.self)) { [weak self](row,model, cell) in
            guard self != nil else {return}
            cell.uiAlbumsLbl.text = model.title
        }.disposed(by: disposeBag)
    }
    
    private func bindModelSelected() {
        uiAlbumsTableView.rx.modelSelected(Albums.self).subscribe { [weak self] model in
            guard self != nil else {return}
            let albumsViewModel = AlbumsViewModel(album: model)
            let albumsViewController = AlbumsViewController(viewModel: albumsViewModel)
            self?.navigationController?.pushViewController(albumsViewController, animated: true)
        }.disposed(by: disposeBag)
        
    }
}

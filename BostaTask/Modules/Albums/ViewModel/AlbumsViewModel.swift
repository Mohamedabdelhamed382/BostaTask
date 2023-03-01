//
//  AlbumsViewModel.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation
import Moya
import RxSwift
import RxRelay

class AlbumsViewModel: BaseViewModel {
    
    private let networkService: MoyaProvider<NetworkClient>
    let album: Albums?
    var photoAlbumsResponse: PublishSubject<[PhotoAlbum]> = .init()
    var searchValueBehavior = BehaviorRelay<String?>(value: "")
    var isDataOfSeachExist: BehaviorRelay<Bool> = .init(value: false)
    
    var photoAlbumsSubjects: Observable<[PhotoAlbum]> { Observable.combineLatest(
        searchValueBehavior
            .map { $0 ?? "" }
            .startWith("")
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance),
        photoAlbumsResponse
    )
            .map { searchValue, allPhotos in
                searchValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? allPhotos : allPhotos.filter { $0.title!.lowercased().contains(searchValue.lowercased())}
                
            }
    }

    init(networkService: MoyaProvider<NetworkClient> = MoyaProvider<NetworkClient>(), album: Albums) {
        self.networkService = networkService
        self.album = album
        super.init()
        self.getDataFromUserAlbum()
        self.subscribeToTextFeild()
        photoAlbumsSubjects.subscribe { [weak self] response in
            guard let isEmpty = response.element?.isEmpty else {return}
            if isEmpty {
                self?.isDataOfSeachExist.accept(isEmpty)
            } else {
                self?.isDataOfSeachExist.accept(false)
            }
        }.disposed(by: disposeBag)
        
    }
    
    func getDataFromUserAlbum() {
        guard let id = album?.id else {return}
        self.fetchAlbums(photosAlbumId: "\(id)")
    }
    
    private func fetchAlbums(photosAlbumId: String) {
        self.isLoading.onNext(true)
        networkService.rx.request(.getPhotos(albumId: photosAlbumId)).subscribe { [weak self] event in
            guard let self = self else {return}
                switch event {
                case let .success(response):
                    self.isLoading.onNext(false)
                    do {
                        let filterResponse = try response.filterSuccessfulStatusCodes()
                        let albumsResponse = try filterResponse.map([PhotoAlbum].self,using: JSONDecoder())
                       self.photoAlbumsResponse.onNext(albumsResponse)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    self.isLoading.onNext(false)
                    self.showMessageObservable.onNext((nil, error.localizedDescription))
                }
        }.disposed(by: disposeBag)
    }
    
    func subscribeToTextFeild() {
        searchValueBehavior.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe { [weak self] result in
            guard self != nil else {return}
            guard let searchtext = result.element else {return}
            if let searchtext = searchtext?.trimmingCharacters(in: .whitespacesAndNewlines),!searchtext.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                
            } else {
                
            }
        }.disposed(by: disposeBag)
    }
}

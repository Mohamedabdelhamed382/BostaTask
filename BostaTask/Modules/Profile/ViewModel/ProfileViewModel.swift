//
//  ProfileViewModel.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation
import Moya
import RxSwift

class ProfileViewModel: BaseViewModel {
    
    private let networkService: MoyaProvider<NetworkClient>
    var usersResponse: PublishSubject<UsersResponseElement> = .init()
    var albumsResponse: PublishSubject<AlbumsResponse> = .init()
    
    init(networkService: MoyaProvider<NetworkClient> = MoyaProvider<NetworkClient>()) {
        self.networkService = networkService
        super.init()
        self.featchUsers()
        
    }
    
    private func featchUsers() {
        self.isLoading.onNext(true)
        networkService.rx.request(.getUsers).subscribe { [weak self] event in
            guard let self = self else {return}
                switch event {
                case let .success(response):
                    self.isLoading.onNext(false)
                    do {
                        let filterResponse = try response.filterSuccessfulStatusCodes()
                        let usersResponse = try filterResponse.map(UsersResponse.self,using: JSONDecoder())
                        guard let usersResponse = usersResponse.randomElement(),  let id = usersResponse.id else {return}
                        print("usersResponse",usersResponse)
                        self.fetchAlbums(userId: String(id))
                        self.usersResponse.onNext(usersResponse)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    self.isLoading.onNext(false)
                    self.showMessageObservable.onNext((nil, error.localizedDescription))
                }
        }.disposed(by: disposeBag)
    }
    
    private func fetchAlbums(userId: String) {
        self.isLoading.onNext(true)
        networkService.rx.request(.getAlbums(userId: userId)).subscribe { [weak self] event in
            guard let self = self else {return}
                switch event {
                case let .success(response):
                    self.isLoading.onNext(false)
                    do {
                        let filterResponse = try response.filterSuccessfulStatusCodes()
                        let albumsResponse = try filterResponse.map([Albums].self,using: JSONDecoder())
                       self.albumsResponse.onNext(albumsResponse)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    self.isLoading.onNext(false)
                    self.showMessageObservable.onNext((nil, error.localizedDescription))
                }
        }.disposed(by: disposeBag)
    }
}



//
//  CommanVieModel.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation
import Moya
import RxSwift

class BaseViewModel: NSObject{
    var disposeBag = DisposeBag()
    var isLoading: BehaviorSubject<Bool> = .init(value: false)
    lazy var showMessageObservable: PublishSubject<(String?, String)> = .init()
    lazy var showMessageObservableWithAction: PublishSubject<(String?, String, PublishSubject<Void>)> = .init()

}

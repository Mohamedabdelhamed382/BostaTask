//
//  CommanViewController.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class BaseWireFrame<T: BaseViewModel>: UIViewController {
    var viewModel: T!
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    private lazy var indicator:UIActivityIndicatorView = {
        var activityView = UIActivityIndicatorView(style: .large)
        return activityView
    }()
    
    private lazy var bgColorView = UIView()
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        self.baseBind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    func bind(viewModel: T){
        fatalError("Please override bind function")
    }
    func baseBind(){
       
        viewModel.showMessageObservableWithAction.subscribe{[weak self] (title, message, observable) in
            guard let self = self else {return}
            self.showMessage(title: title, message: message, observable: observable)
        }.disposed(by: self.disposeBag)
        viewModel.showMessageObservable.subscribe {[weak self] (title, message) in
            guard let self = self else {return}
            self.showMessage(title: title, message: message, observable: nil)
        }.disposed(by: self.disposeBag)
        
        viewModel.isLoading.subscribe(onNext:{[weak self] isShow in
            guard let self = self else{return}
            isShow ? self.showActivityIndicatory() : self.removeActivity()
        }).disposed(by: self.disposeBag)
       
    }
    
  
    
    func showMessage(title: String?, message: String, observable: PublishSubject<Void>?){
        let messageAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        self.present(messageAlert, animated: true, completion: nil)
    }
    
    func showActivityIndicatory() {
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: .gray)
        }
       // indicator.backgroundColor = .red
        indicator.center = self.view.center
        bgColorView.backgroundColor = UIColor(white: 0, alpha: 0)
        self.view.addSubview(bgColorView)
        bgColorView.translatesAutoresizingMaskIntoConstraints = false
        bgColorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bgColorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bgColorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        bgColorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    func removeActivity(){
        indicator.stopAnimating()
        bgColorView.removeFromSuperview()
        indicator.removeFromSuperview()
    }
}

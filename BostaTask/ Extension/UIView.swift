//
//  UIView.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation
import UIKit
import RxSwift

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.borderColor = color.cgColor
      } else {
        layer.borderColor = nil
      }
    }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable
  var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  var shadowColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.shadowColor = color.cgColor
      } else {
        layer.shadowColor = nil
      }
    }
  }
}

enum NotFoundType{
    
    case searchNotFound

    
    var image: UIImage?{
        switch self {
        case .searchNotFound:
            return UIImage(named: "searchNotFound")
        }
    }
    
    var title: String?{
        switch self {
        case .searchNotFound:
            return "Not found!"
        }
    }
    
    var message: String?{
        switch self {
        case .searchNotFound:
            return "The object that you are searching for is not found in this sub category, You may found it in another sub category."
        }
    }
}

extension UIView {
    
    //Variadic
    func addSubviews(_ views: UIView...) {
        views.forEach({self.addSubview($0)})
    }
}

class NotFoundView: UIView{
    
    let disposeBag: DisposeBag = DisposeBag()
    
    private var title: String? = ""
    private var message: String? = ""
    private var image: UIImage? = nil
    
    var image_ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title_lbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var message_lbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(type: NotFoundType?){
        self.title = type?.title
        self.image = type?.image
        self.message = type?.message
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUpViews()
    }
    
    private func setUpViews(){
        
        self.addSubviews(self.image_ImageView, self.title_lbl, self.message_lbl)
        
        NSLayoutConstraint.activate([
            self.image_ImageView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.7),
            self.image_ImageView.heightAnchor.constraint(equalToConstant: self.frame.width * 0.6),
            self.image_ImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.image_ImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -85)
        ])
        
        NSLayoutConstraint.activate([
            self.title_lbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.title_lbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.title_lbl.topAnchor.constraint(equalTo: self.image_ImageView.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            self.message_lbl.leadingAnchor.constraint(equalTo: self.title_lbl.leadingAnchor, constant: 0),
            self.message_lbl.trailingAnchor.constraint(equalTo: self.title_lbl.trailingAnchor, constant: 0),
            self.message_lbl.widthAnchor.constraint(equalToConstant: self.frame.width-50),
            self.message_lbl.topAnchor.constraint(equalTo: self.title_lbl.bottomAnchor, constant: 10)
        ])
        
        self.image_ImageView.image = self.image
        self.title_lbl.text = self.title
        self.message_lbl.text = self.message
      
        
    }
    
}

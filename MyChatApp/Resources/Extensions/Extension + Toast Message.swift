//
//  Extension + Toast Message.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import UIKit

extension UIView {
    
    enum ToastType {
        case success, error
    }
    
    enum ToastPosition {
        case top, center, bottom
    }
    
    
    func showToast(msg: String,
                   type: ToastType = .success,
                   duration: Double = 3,
                   pos: ToastPosition = .top) {
        let toastView: UIView = {
           let view = UIView()
            
            let msgLabel = UILabel(text: msg)
            view.addSubview(msgLabel)
            
            msgLabel.anchor(top: view.topAnchor,
                            right: view.rightAnchor,
                            bottom: view.bottomAnchor,
                            left: view.leftAnchor,
                            paddingTop: 10,
                            paddingRight: 10,
                            paddingBottom: 10,
                            paddingLeft: 10)
            msgLabel.textAlignment = .center
            msgLabel.numberOfLines = 0
            switch type {
            case .error:
                view.backgroundColor = .red
            case .success:
                view.backgroundColor = .systemGreen
            }
            return view
        }()
        
        toastView.alpha = 1
        toastView.cornerRadius = 10
        self.addSubview(toastView)
        
        toastView.anchor(right: rightAnchor,
                         left: leftAnchor,
                         paddingRight: 30,
                         paddingLeft: 30)
        
        switch pos {
        case .top:
            toastView.anchor(top: topAnchor, paddingTop: 25)
        case .center:
            toastView.centerYInSuperView()
        case .bottom:
            toastView.anchor(bottom: bottomAnchor, paddingBottom: 25)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut) {
                toastView.alpha = 1.0
            } completion: { _ in
                UIView.animate(withDuration: 0.8, delay: 0.1, options: .curveEaseInOut) {
                    toastView.alpha = 0
                } completion: { _ in
                    toastView.removeFromSuperview()
                }
            }

        }
    }
}

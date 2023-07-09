//
//  Extension + ViewController.swift
//  MyChatApp
//
//  Created by mac on 08/07/2023.
//

import UIKit

extension UIViewController: ViewModelDependencies {
    
    func pushViewController(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

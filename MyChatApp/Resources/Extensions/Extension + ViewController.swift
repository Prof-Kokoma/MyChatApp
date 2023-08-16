//
//  Extension + ViewController.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import UIKit
import JGProgressHUD

extension UIViewController: ViewModelDependencies {
    
    var progressIndicator: JGProgressHUD {
        return JGProgressHUD()
    }
    
    func pushViewController(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func dismissView() {
        dismiss(animated: true)
    }
    
    func display(vc: UIViewController) {
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: false)
    }
}

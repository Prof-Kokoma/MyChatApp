//
//  ViewController.swift
//  MyChatApp
//
//  Created by mac on 08/07/2023.
//

import UIKit

class ConversationViewController: UIViewController {

    var vm: ConversationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        vm = conversationViewModel
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let isLoggedIn = vm?.isUserLoggedIn {
            if !isLoggedIn {
                let vc = LoginViewController()
                let navController = UINavigationController(rootViewController: vc)
                navController.modalPresentationStyle = .fullScreen
                present(navController, animated: false)
            }
        }
    }
}


//
//  LoginViewController.swift
//  MyChatApp
//
//  Created by mac on 08/07/2023.
//

import UIKit

class LoginViewController: UIViewController {

    private var loginView = LoginView()
    private var vm: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Login"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        view.addSubview(loginView)
        vm = loginViewModel
        loginView.vm = vm
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginView.fillSuperView()
    }
    

    @objc
    private func didTapRegister() {
        print("User tapped register")
        let vc = RegisterViewController()
        vc.title = "Create Account"
        pushViewController(vc: vc)
    }
}

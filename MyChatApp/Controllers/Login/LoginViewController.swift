//
//  LoginViewController.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import UIKit
import Combine
import JGProgressHUD

class LoginViewController: UIViewController {
    
    private var loginView = LoginView()
    private var vm: LoginViewModel?
    private var cancellables = Set<AnyCancellable>()
    private var hud: JGProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Login"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        hud = progressIndicator
        view.addSubview(loginView)
        vm = loginViewModel
        loginView.vm = vm
        viewModelListener()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hud?.show(in: self.view)
        vm?.reAuth()
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
    
    func viewModelListener() {
        vm?.$errorMsg
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] errorMessage in
                guard let self,
                      let errorMessage,
                      !errorMessage.isEmpty else { return }
                view.showToast(msg: errorMessage, type: .error, duration: 4, pos: .center)
            })
            .store(in: &cancellables)
        
        vm?.$loginSuccessful
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] loggedIn in
                guard let self else { return }
                hud?.dismiss(afterDelay: 0.5)
                if loggedIn {
                    dismissView()
                }
            })
            .store(in: &cancellables)
        
        vm?.$isUserNotLoggedIn
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] loggedIn in
                guard let self else { return }
                if !loggedIn {
                    hud?.dismiss(afterDelay: 0.5)
                    dismissView()
                }
            })
            .store(in: &cancellables)
    }
}

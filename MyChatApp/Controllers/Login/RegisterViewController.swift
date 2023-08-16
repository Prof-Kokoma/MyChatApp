//
//  RegisterViewController.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    
    private var registerView = RegisterView()
    private var vm: LoginViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Create Account"
        
        view.addSubview(registerView)
        vm = loginViewModel
        registerView.vm = vm
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        registerView.profilePicture.addGestureRecognizer(gesture)
        viewModelListener()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerView.fillSuperView()
    }
    
    @objc
    private func didTapChangeProfilePic() {
        registerView.presentPhotoActionSheet(vc: self, conformer: self.registerView)
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
                if loggedIn {
                    dismissView()
                }
            })
            .store(in: &cancellables)
    }
    
}

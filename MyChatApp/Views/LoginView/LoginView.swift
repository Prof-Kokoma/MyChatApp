//
//  LoginView.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Combine
import UIKit

class LoginView: UIView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let logoView: UIImageView = UIImageView(
        image: UIImage(systemName: "ellipsis.message.fill")
    )
    
    private let emailField: UITextField = UITextField(placeholder: "Email Address...",
                                                      isSecureField: false)
    private let passwordField: UITextField = UITextField(placeholder: "Password...",
                                                         isSecureField: true)
    private let loginButton: UIButton = UIButton(title: "Log In")
    var cancellables = Set<AnyCancellable>()
    var vm: LoginViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview([
            logoView,
            emailField,
            passwordField,
            loginButton
        ])
        configureLoginButton()
        activateButton(activate: false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = size.width / 3
        scrollView.frame = self.bounds
        logoView.centerXInSuperView(topAnchor: scrollView.topAnchor,
                                    paddingTop: 20,
                                    width: width,
                                    height: width)
        
        print("The width = \(width)")
        emailField.anchor(top: logoView.bottomAnchor,
                          right: scrollView.rightAnchor,
                          left: scrollView.leftAnchor,
                          paddingTop: 20,
                          paddingRight: 30,
                          paddingLeft: 30,
                          width: self.width - 60,
                          height: 52)
        
        passwordField.anchor(top: emailField.bottomAnchor,
                             right: emailField.rightAnchor,
                             left: emailField.leftAnchor,
                             paddingTop: 10,
                             height: 52)
        
        loginButton.anchor(top: passwordField.bottomAnchor,
                             right: passwordField.rightAnchor,
                             left: passwordField.leftAnchor,
                             paddingTop: 10,
                             height: 52)
    }
    
    @objc
    private func loginButtonTapped(_ sender: UIButton) {
        loginInProgress()
        vm?.loginRegisteredUser()
    }
    
    func loginInProgress() {
        guard let vm else { return }
        self.showToast(msg: "Logging-In in progress... with: \(vm.emailText)")
    }
    
    func configureLoginButton() {
        let combines = Publishers.CombineLatest(emailField.textPublisher,
                                                passwordField.textPublisher)
        combines
        .map{ (emailField, passwordField) in
            return (emailField, passwordField)
        }
        .sink(receiveValue: { [weak self] (email, password) in
            guard let self, let vm else { return }
            vm.emailText = email
            vm.passwordText = password
            if email.isEmpty || password.isEmpty || !email.contains(".com") {
                activateButton(activate: false)
            } else {
                activateButton(activate: true)
            }
            
        })
        .store(in: &cancellables)
        
        emailField.textPublisher
            .sink { [weak self] text in
                guard let self, text.isNotEmpty() else {
                    self?.setupTextField(textField: self?.emailField ?? UITextField(), borderWidth: 1, borderColor: .black)
                    return
                }
                setupTextField(textField: emailField, borderWidth: 1, borderColor: .lightGray)
            }
            .store(in: &cancellables)
        
        emailField.beginEditing
            .sink { [weak self] begin in
                guard let self else { return }
                if begin {
                    setupTextField(textField: emailField)
                }
            }
            .store(in: &cancellables)
        
        emailField.endEditing
            .sink { [weak self] end in
                guard let self,
                        let emailText = emailField.text else { return }
                if end {
                    if !emailText.contains(".com") {
                        setupTextField(textField: emailField, borderWidth: 1, borderColor: .red)
                    } else {
                        setupTextField(textField: emailField, borderWidth: 1, borderColor: .link)
                    }
                } else {
                    emailField.backgroundColor = .yellow
                }
            }
            .store(in: &cancellables)
        
        emailField.shouldReturnPressed
            .sink { [passwordField] textfield in
                print("I am testing here")
                textfield.resignFirstResponder()
                passwordField.becomeFirstResponder()
            }
            .store(in: &cancellables)
        
        let shouldLoginPublisher = Publishers.CombineLatest3(
            passwordField.shouldReturnPressed,
            emailField.textPublisher,
            passwordField.textPublisher)
        
        passwordField.shouldReturnPressed
            .sink { textfield in
                print("I am testing here")
                textfield.resignFirstResponder()

                if let email = self.emailField.text,
                   let password = self.passwordField.text {
                    self.vm?.emailText = email
                    self.vm?.passwordText = password
                    self.checkEmptyStrings(email: email, password: password)
                }
                
            }
            .store(in: &cancellables)
        
        loginButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self, let vm else { return }
                print("Will login the user here")
                loginInProgress()
                vm.loginRegisteredUser()
            }
            .store(in: &cancellables)
    }
    
    func setupTextField(textField: UITextField, borderWidth: CGFloat = 1, borderColor: UIColor = .black) {
        textField.borderWidth = borderWidth
        textField.borderColor = borderColor
    }
    
    func checkEmptyStrings(email: String, password: String) {
        if email.isEmpty || !email.contains(".com") {
            activateButton(activate: false)
            passwordField.resignFirstResponder()
            emailField.becomeFirstResponder()
        }
        else if password.isEmpty {
            passwordField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            setupTextField(textField: passwordField, borderWidth: 1, borderColor: .red)
        }
        else {
            activateButton(activate: true)
            self.loginInProgress()
        }
    }
    
    func activateButton(activate: Bool) {
        loginButton.isUserInteractionEnabled = activate
        loginButton.backgroundColor = activate ? .link : .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  LoginViewModel.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Foundation
import Combine

class LoginViewModel {
    
    var firstNameText: String = ""
    var lastNameText: String = ""
    var emailText: String = ""
    var passwordText: String = ""
    @Published var errorMsg: String? = ""
    @Published var loginSuccessful: Bool = false
    @Published var isUserNotLoggedIn: Bool = true
    
    init() {
        
    }
    
    func registeringUser() {
        print("Here are the user data: \(emailText) - \(lastNameText) - \(emailText) - \(passwordText)")
        let formattedEmail = emailText.replacingOccurrences(of: ".", with: "_")
        userEmailExist(email: formattedEmail) { [weak self] exist in
            guard let self,
                  !exist else {
                self?.errorMsg = "User exist already"
                return
            }
            registerUser(email: emailText, password: passwordText) { [weak self] result in
                guard let self,
                      let email = result.user.email else { return }
                loginSuccessful = true
                let userData = ChatAppUser(firstName: firstNameText, lastName: lastNameText, email: formattedEmail)
                print("Here is the user data: \(userData)")
                createNewUser(with: userData)
            } errorHandler: { [weak self] error in
                guard let self else { return }
                errorMsg = error
            }
        }
        
    }
    
    func loginRegisteredUser() {
        signIn(with: emailText, and: passwordText) { [weak self] result in
            guard let self else { return }
            loginSuccessful = true
        } errorHandler: { [weak self] error in
            guard let self else { return }
            errorMsg = error
            loginSuccessful = false
        }
    }
    
    func reAuth() {
        isUserNotLoggedIn = validateCurrentUser()
    }
    
}

extension LoginViewModel: RegisterUserInterface { }
extension LoginViewModel: ValidateCurrentUser { }
extension LoginViewModel: DatabaseInterface { }

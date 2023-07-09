//
//  ConversationViewModel.swift
//  MyChatApp
//
//  Created by mac on 08/07/2023.
//

import Foundation

class ConversationViewModel {
    @Published var isUserLoggedIn: Bool = false
    
    init() {
        getUserLoginState()
    }
    
    func getUserLoginState() {
        if let userLoggedIn = retrieveData(UserdefaultKeys.login.identifier, type: Bool.self) {
            isUserLoggedIn = userLoggedIn
        }
    }
}

extension ConversationViewModel: UserdefaultDataStorageInterface { }

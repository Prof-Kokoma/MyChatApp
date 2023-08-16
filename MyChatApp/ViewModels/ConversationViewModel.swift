//
//  ConversationViewModel.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Foundation

class ConversationViewModel {
    @Published var isUserLoggedIn: Bool = false
    
    init() {
        getUserLoginState()
    }
    
    func getUserLoginState() {
        isUserLoggedIn = !validateCurrentUser()
    }
}

extension ConversationViewModel: UserdefaultDataStorageInterface { }
extension ConversationViewModel: ValidateCurrentUser { }

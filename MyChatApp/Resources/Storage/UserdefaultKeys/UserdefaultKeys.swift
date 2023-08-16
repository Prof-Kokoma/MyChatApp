//
//  UserdefaultKeys.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Foundation

enum UserdefaultKeys {
    case login
    
    
    var identifier: String {
        switch self {
        case .login:
            return "user_login"
        }
    }
}

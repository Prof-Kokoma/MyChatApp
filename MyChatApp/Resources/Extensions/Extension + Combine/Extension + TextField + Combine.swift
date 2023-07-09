//
//  Extension + TextField + Combine.swift
//  MyChatApp
//
//  Created by mac on 08/07/2023.
//

import Combine
import UIKit

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
    
    var beginEditing: AnyPublisher<Bool, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification, object: self)
            .compactMap { object in
                guard let textfield = object.object as? UITextField else { return false }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    var endEditing: AnyPublisher<Bool, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .compactMap { object in
                guard let textfield = object.object as? UITextField else { return false }
                return true
            }
            .eraseToAnyPublisher()
    }
}

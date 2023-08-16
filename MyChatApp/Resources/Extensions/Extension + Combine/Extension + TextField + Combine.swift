//
//  Extension + TextField + Combine.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
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
                guard object.object is UITextField else { return false }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    var shouldReturnPressed: AnyPublisher<UITextField, Never> {
        NotificationCenter.default.publisher(for: Notification.Name("shouldReturnPressed"), object: self)
            .compactMap { object in
                guard let textfield = object.object as? UITextField else { return UITextField()}
                return textfield
            }
            .eraseToAnyPublisher()
    }
    
    @objc
    func shoudReturn(_ textfield: UITextField) {
        print("The return or continue button tapped")
        NotificationCenter.default.post(name: Notification.Name("shouldReturnPressed"), object: textfield)
    }
}

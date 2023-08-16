//
//  Extension + UIButton + Combine.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Combine
import UIKit

extension UIButton {
    var tapPublisher: AnyPublisher<UIButton, Never> {
        NotificationCenter.default.publisher(for: Notification.Name("DidTapButton"), object: self)
            .compactMap { object in
                guard let button = object.object as? UIButton else { return UIButton() }
                return button
            }
            .eraseToAnyPublisher()
    }
    
    @objc
    func buttonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("DidTapButton"), object: sender)
    }
}

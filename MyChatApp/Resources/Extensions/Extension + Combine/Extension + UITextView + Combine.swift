//
//  Extension + UITextView + Combine.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Combine
import UIKit

extension UITextView {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextView)?.text}
            .eraseToAnyPublisher()
    }
}

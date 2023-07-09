//
//  Extension + Label.swift
//  MyChatApp
//
//  Created by mac on 08/07/2023.
//

import UIKit

extension UILabel {
    convenience init(text: String,
                     font: UIFont = .systemFont(ofSize: 14, weight: .semibold),
                     textColor: UIColor = .white) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}

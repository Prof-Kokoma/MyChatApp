//
//  Extension + UIButton + Combine.swift
//  MyChatApp
//
//  Created by mac on 08/07/2023.
//

import Combine
import UIKit

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        return Future<Void, Never> { [weak self] promise in
            guard let self else { return }
            self.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.sendActions(for: .touchUpInside)
        }
    }
}

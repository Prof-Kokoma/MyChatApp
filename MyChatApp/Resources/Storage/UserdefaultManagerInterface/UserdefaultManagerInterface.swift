//
//  UserdefaultManagerInterface.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Foundation

protocol UserdefaultManagerInterface: DataStorableInterface { }

extension UserdefaultManagerInterface {
    func setData(value: Data, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getData(key: String) -> Data? {
        UserDefaults.standard.data(forKey: key)
    }
    
    func deleteData(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func deleteAllData() {
        if let identifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: identifier)
            UserDefaults.standard.synchronize()
        }
    }
}

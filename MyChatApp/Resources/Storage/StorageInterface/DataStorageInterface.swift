//
//  DataStorageInterface.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Foundation

protocol UserdefaultDataStorageInterface: CodableInterface, UserdefaultManagerInterface {
    func retrieveData<T: Codable>(_ key: String, type: T.Type) -> T?
    func storeData<T: Codable>(_ value: T, key: String)
    func deleteStoredData(key: String)
    func deleteAllStoredData()
}

extension UserdefaultDataStorageInterface {
    func storeData<T: Codable>(_ value: T, key: String) {
        if let storableValue = encodeData(value) {
            setData(value: storableValue, key: key)
        }
    }
    
    func retrieveData<T: Codable>(_ key: String, type: T.Type) -> T? {
        guard let data = getData(key: key) else {
            return nil
        }
        return decodeData(type, from: data)
    }
    
    func deleteStoredData(key: String) {
        deleteData(key: key)
    }
    
    func deleteAllStoredData() {
        deleteAllData()
    }
}

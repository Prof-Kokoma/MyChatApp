//
//  DataStorableInterface.swift
//  MyChatApp
//
//  Created by Prof K on 08/07/2023.
//

import Foundation

protocol DataStorableInterface {
    func setData(value: Data, key: String)
    func getData(key: String) -> Data?
    func deleteData(key: String)
    func deleteAllData()
}

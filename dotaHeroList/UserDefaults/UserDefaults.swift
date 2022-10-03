//
//  UserDefaults.swift
//  dotaHeroList
//
//  Created by Caroline Chan on 03/10/22.
//

import Foundation

extension UserDefaults {
    func setDataToLocal<T: Codable>(object: T, with key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getDataFromLocal<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else {return nil}
        return try? decoder.decode(type.self, from: data)
    }
}

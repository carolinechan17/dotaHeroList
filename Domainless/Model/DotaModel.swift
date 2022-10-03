//
//  DotaModel.swift
//  dotaHeroList
//
//  Created by Caroline Chan on 03/10/22.
//

import Foundation

// MARK: - DotaModelElement
struct DotaModelElement: Codable {
    let id: Int
    let name, localizedName: String
    let primaryAttr: String
    let attackType: String
    let roles: [String]
    let legs: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles, legs
    }
}

typealias DotaModel = [DotaModelElement]

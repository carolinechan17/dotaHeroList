//
//  DotaServices.swift
//  dotaHeroList
//
//  Created by Caroline Chan on 03/10/22.
//

import Foundation

protocol DotaServicesProtocol: AnyObject {
    var networker: NetworkerProtocol {get}
    func getHero(endPoint: NetworkFactory) async throws -> DotaModel
}

final class DotaServices: DotaServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getHero(endPoint: NetworkFactory) async throws -> DotaModel {
        return try await networker.taskAsync(type: DotaModel.self, endPoint: endPoint, isMultipart: false)
    }
}

//
//  Protocols.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 06.12.2022.
//

import Foundation

protocol GetDataManager {
    func loadData(from source: String) async throws -> Data
}


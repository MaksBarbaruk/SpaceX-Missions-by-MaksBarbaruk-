//
//  DataManager.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 22.10.2022.
//

import Foundation

class DataManager: GetDataManager, ObservableObject {

    func loadData(from source: String) async throws -> Data {
        
        guard let url = URL(string: source) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
            
        } catch {
            throw error
        }
        
    }
}

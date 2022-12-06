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
            let (data, response) = try await URLSession.shared.data(from: url)
            if let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                return data
            } else {
                throw URLError(.badServerResponse)
            }
            
        } catch {
            throw error
        }
        
    }
}

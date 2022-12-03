//
//  DataManager.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 22.10.2022.
//

import Foundation


class DataManager: ObservableObject {
    @Published var rockets: [Rocket] = []
    @Published var launches: [Launch] = []
    
    func loadData() async throws {
        
        guard let rocketUrl = URL(string: "https://api.spacexdata.com/v4/rockets") else {
            throw URLError(.badURL)
        }
        
        guard let launchesUrl = URL(string: "https://api.spacexdata.com/v4/launches") else {
            throw URLError(.badURL)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            async let (rocketData, _) = try await URLSession.shared.data(from: rocketUrl)
            async let (launchesData, _) = try await URLSession.shared.data(from: launchesUrl)
            
            self.launches = try await decoder.decode([Launch].self, from: launchesData)
            decoder.dateDecodingStrategy = try getLaunchesDecodingStrategy()
            self.rockets = try await decoder.decode([Rocket].self, from: rocketData)
            
        } catch {
            throw error
        }
        
    }
    
    private func getLaunchesDecodingStrategy() throws -> JSONDecoder.DateDecodingStrategy {
        let formatter = DateFormatter()
        return .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = formatter.date(from: dateString) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Cannot decode date string \(dateString)")
        }
    }
}

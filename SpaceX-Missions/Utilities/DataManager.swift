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
    
    func loadData() async {
        
        guard let rocketUrl = URL(string: "https://api.spacexdata.com/v4/rockets") else {
            print("Invalid URL")
            return
        }
        
        guard let launchesUrl = URL(string: "https://api.spacexdata.com/v4/launches") else {
            print("Invalid URL")
            return
        }
        
        do {
            let formatter = DateFormatter()
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            let (rocketData, _) = try await URLSession.shared.data(from: rocketUrl)
            let (launchesData, _) = try await URLSession.shared.data(from: launchesUrl)
            
            if let launches = try? decoder.decode([Launch].self, from: launchesData) {
                self.launches = launches
            }
            
            
            decoder.dateDecodingStrategy = .custom { decoder in
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
            if let rockets = try? decoder.decode([Rocket].self, from: rocketData) {
                self.rockets = rockets
            }
            
        } catch {
            print("Invalid data")
        }
        
    }
    
}

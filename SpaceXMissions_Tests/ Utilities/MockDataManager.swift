//
//  MockDataManager.swift
//  SpaceXMissions_Tests
//
//  Created by MaksBarbaruk on 29.12.2022.
//

import Foundation
@testable import SpaceX_Missions

final class MockDataManager: GetDataManager {
    

    func loadData(from source: String) async throws -> Data {
        
        var rockets: [Rocket] = []
        var launches: [Launch] = []
        
        do {
            
            let rocket = Rocket.example
            let launch = Launch(name: "MockRocket", dateLocal: Date.now, success: true, id: UUID().uuidString, rocket: rocket.name)
            
            rockets.append(rocket)
            launches.append(launch)
            
            let rocketData = try JSONEncoder().encode(rockets)
            let launchData = try JSONEncoder().encode(launches)
            if source.contains("rockets") {
                print("rockets return")
                return rocketData
                
            } else {
                print("launches return")
                return launchData
                
            }
        } catch {
            throw error
        }
//        guard let url = URL(string: source) else {
//            throw URLError(.badURL)
//        }
//
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//            if let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 {
//                return data
//            } else {
//                throw URLError(.badServerResponse)
//            }
//
//        } catch {
//            throw error
//        }
        
    }
}

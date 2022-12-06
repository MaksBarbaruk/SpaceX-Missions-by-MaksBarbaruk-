//
//  ViewModel.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 06.02.2022.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var rockets: [Rocket] = []
    @Published var launches: [Launch] = []
    @Published var metrics = Metrics() {
        didSet {
            if let encoded = try? JSONEncoder().encode(metrics) {
                UserDefaults.standard.set(encoded, forKey: "Metrics")
            }
        }
    }
    
    let dataManager: GetDataManager
    let rocketsURLString: String
    let launchesURLString: String
    
    init(dataManager: GetDataManager = DataManager(),
         rocketsURLString: String = "https://api.spacexdata.com/v4/rockets",
         launchesURLString: String = "https://api.spacexdata.com/v4/launches") {
        
        self.dataManager = dataManager
        self.rocketsURLString = rocketsURLString
        self.launchesURLString = launchesURLString
        
        setupMetrics()
        setupDecoder()
    }
    
    func loadData() async throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            
            async let rocketData = try await dataManager.loadData(from: rocketsURLString)
            async let launchesData = try await dataManager.loadData(from: launchesURLString)
            
            let temporaryLaunches = try await decoder.decode([Launch].self, from: launchesData)
            decoder.dateDecodingStrategy = try getLaunchesDecodingStrategy()
            let temporaryRockets = try await decoder.decode([Rocket].self, from: rocketData)
            
            await MainActor.run(body: {
                self.rockets = temporaryRockets
                self.launches = temporaryLaunches
            })
            
        } catch {
            throw error
        }
    }
    
    private func setupDecoder() {
        
    }
    
    private func setupMetrics() {
        if let savedMetrics = UserDefaults.standard.data(forKey: "Metrics") {
            if let decodedItems = try? JSONDecoder().decode(Metrics.self, from: savedMetrics) {
                metrics = decodedItems
                return
            }
        }
        metrics = Metrics()
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

//
//  ViewModel.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
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
    let decoder: JSONDecoder
    let rocketsURLString: String
    let launchesURLString: String
    
    init(dataManager: GetDataManager = DataManager(),
         decoder: JSONDecoder = .customSpaceXDecoder(),
         rocketsURLString: String = "https://api.spacexdata.com/v4/rockets",
         launchesURLString: String = "https://api.spacexdata.com/v4/launches") {
        
        self.dataManager = dataManager
        self.decoder = decoder
        self.rocketsURLString = rocketsURLString
        self.launchesURLString = launchesURLString
        
        setupMetrics()
    }
    
    @MainActor
    func loadData() async throws {
        
        do {
            
            async let rocketData = try await dataManager.loadData(from: rocketsURLString)
            async let launchesData = try await dataManager.loadData(from: launchesURLString)
            
            let temporaryLaunches = try await decoder.decode([Launch].self, from: launchesData)
            let temporaryRockets = try await decoder.decode([Rocket].self, from: rocketData)
            
            await MainActor.run(body: {
                self.rockets = temporaryRockets
                self.launches = temporaryLaunches
            })
            
        } catch {
            throw error
        }
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
}

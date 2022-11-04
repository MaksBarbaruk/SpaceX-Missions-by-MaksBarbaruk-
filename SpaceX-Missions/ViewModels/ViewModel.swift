//
//  ViewModel.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 06.02.2022.
//

import Foundation

class ViewModel: ObservableObject {
    @MainActor @Published var rockets: [Rocket] = []
    @MainActor @Published var launches: [Launch] = []
    
    @Published var metrics = Metrics() {
        didSet {
            if let encoded = try? JSONEncoder().encode(metrics) {
                UserDefaults.standard.set(encoded, forKey: "Metrics")
            }
        }
    }
    
    let dataManager = DataManager()
    
    init() {
        
        addSubscribers()
        
        if let savedMetrics = UserDefaults.standard.data(forKey: "Metrics") {
            if let decodedItems = try? JSONDecoder().decode(Metrics.self, from: savedMetrics) {
                metrics = decodedItems
                return
            }
        }
        metrics = Metrics()
    }
    
    func addSubscribers() {
        
        Task {
            for await value in dataManager.$launches.values {
                await MainActor.run(body: {
                    self.launches = value
                })
            }
        }
        
        Task {
            for await value in dataManager.$rockets.values {
                await MainActor.run(body: {
                    self.rockets = value
                })
            }
        }
    }
}

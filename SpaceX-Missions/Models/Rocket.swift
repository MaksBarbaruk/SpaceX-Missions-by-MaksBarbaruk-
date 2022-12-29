//
//  Rocket.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
//

import Foundation

struct Rocket: Codable, Identifiable {
    struct Height: Codable {
        let meters: Double
        let feet: Double
    }
    struct Diameter: Codable {
        let meters: Double
        let feet: Double
    }
    struct Mass: Codable {
        let kg: Int
        let lb: Int
    }

    struct Stage: Codable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }

    struct PayloadWeights: Codable {
        let id: String
        let name: String
        let kg: Int
        let lb: Int
    }
    let name: String
    let height: Height
    let diameter: Diameter
    let mass: Mass
    
    let firstStage: Stage
    let secondStage: Stage
    let payloadWeights: [PayloadWeights]
    let flickrImages: [String]

    let costPerLaunch: Int
    let firstFlight: Date
    let country: String
    
    let id: String
    
    func getHeight(heightMetric: String) -> Double {
        return heightMetric == "m" ? self.height.meters : self.height.feet
    }
    
    func getDiameter(diameterMetric: String) -> Double {
        return diameterMetric == "m" ? self.diameter.meters : self.diameter.feet
    }
    
    func getMass(massMetric: String) -> Int {
        return massMetric == "kg" ? self.mass.kg : self.mass.lb
    }
    
    func getPayload(payloadMetric: String) -> Int {
        if let result = payloadWeights.first(where: { $0.id == "leo" }) {
            return payloadMetric == "kg" ? result.kg : result.lb
        }
        return 0
        
    }
    
    static let example = Rocket(name: "ExampleRocket", height: Height(meters: 100, feet: 100), diameter: Diameter(meters: 100, feet: 100), mass: Mass(kg: 100, lb: 100), firstStage: Stage(engines: 100, fuelAmountTons: 100, burnTimeSec: 100), secondStage: Stage(engines: 100, fuelAmountTons: 100, burnTimeSec: 100), payloadWeights: [PayloadWeights(id: "a1a1a1a1", name: "Example", kg: 100, lb: 100)], flickrImages: ["https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg"], costPerLaunch: 1000000, firstFlight: Date.now, country: "USA", id: "e1e1e1e1e1")
    
    // MARK: Accessibility labels
    
    func getHeightAccessibilityLabel(heightMetric: String) -> String {
        let height = getHeight(heightMetric: heightMetric)
        let metric = heightMetric == "m" ? "meters" : "feets"
        return "Height: \(height), \(metric):"
    }
    
    func getDiameterAccessibilityLabel(diameterMetric: String) -> String {
        let diameter = getDiameter(diameterMetric: diameterMetric)
        let metric = diameterMetric == "m" ? "meters" : "feets"
        return "Diameter: \(diameter), \(metric):"
    }
    
    func getMassAccessibilityLabel(massMetric: String) -> String {
        let mass = getMass(massMetric: massMetric)
        let metric = massMetric == "kg" ? "kilograms" : "pounds"
        return "Mass: \(mass), \(metric):"
    }
    
    func getPayloadAccessibilityLabel(payloadMetric: String) -> String {
        let payload = getPayload(payloadMetric: payloadMetric)
        let metric = payloadMetric == "kg" ? "kilograms" : "pounds"
        return "Payload: \(payload), \(metric):"
    }
}

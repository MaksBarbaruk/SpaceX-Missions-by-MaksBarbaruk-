//
//  Metrics.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
//

import Foundation

struct Metrics: Codable {
    
    var heightAndDiameterMetrics = ["m", "ft"]
    var massAndPayloadMetrics = ["kg", "lb"]
    
    var heightMetric = "m"
    var diameterMetric = "m"
    var massMetric = "kg"
    var payloadMetric = "kg"
}

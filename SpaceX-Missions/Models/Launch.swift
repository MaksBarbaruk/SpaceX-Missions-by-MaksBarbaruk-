//
//  Launch.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 06.02.2022.
//

import Foundation

struct Launch: Codable, Identifiable {
    let name: String
    let dateLocal: Date
    let success: Bool?
    let id: String
    let rocket: String
    
    var unwrappedSuccess: Bool {
        success ?? false
    }
    
    // MARK: Accessibility labels
    
    var accessibilityLabel: String {
        return "\(name). Launch date: \(String(dateLocal.formatted(date: .long, time: .omitted))). \(unwrappedSuccess ? "Launch succesed" : "Launch failed")"
    }
}

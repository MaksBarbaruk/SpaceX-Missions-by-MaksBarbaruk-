//
//  SpaceX_MissionsApp.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
//

import SwiftUI

@main
struct SpaceX_MissionsApp: App {
    init() {
        let dataManager = DataManager()
        let decoder = JSONDecoder.customSpaceXDecoder()
        let rocketsURLString: String = "https://api.spacexdata.com/v4/rockets"
        let launchesURLString: String = "https://api.spacexdata.com/v4/launches"
        let vm = ViewModel(dataManager: dataManager,
                           decoder: decoder,
                           rocketsURLString: rocketsURLString,
                           launchesURLString: launchesURLString)
        
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    @StateObject var viewModel: ViewModel
    
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environmentObject(viewModel)
        }
    }
}

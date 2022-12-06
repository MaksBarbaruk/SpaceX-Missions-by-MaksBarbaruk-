//
//  SpaceX_MissionsApp.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 06.02.2022.
//  GIT loaded

import SwiftUI

@main
struct SpaceX_MissionsApp: App {
    init() {
        let dataManager = DataManager()
        let rocketsURLString: String = "https://api.spacexdata.com/v4/rockets"
        let launchesURLString: String = "https://api.spacexdata.com/v4/launches"
        let vm = ViewModel(dataManager: dataManager,
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

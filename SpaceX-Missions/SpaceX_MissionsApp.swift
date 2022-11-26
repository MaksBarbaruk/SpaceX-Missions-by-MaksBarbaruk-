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
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
    
    @StateObject var viewModel: ViewModel
    
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environmentObject(viewModel)
        }
    }
}

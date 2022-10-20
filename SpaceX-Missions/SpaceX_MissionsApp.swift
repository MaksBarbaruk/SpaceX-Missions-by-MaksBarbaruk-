//
//  SpaceX_MissionsApp.swift
//  SpaceX-Missions
//
//  Created by Admin on 06.08.2022.
//  GIT loaded

import SwiftUI

@main
struct SpaceX_MissionsApp: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

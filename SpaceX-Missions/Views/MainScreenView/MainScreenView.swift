//
//  ContentView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @State private var alertPresent = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if !viewModel.rockets.isEmpty {
                    tabView
                } else {
                    ProgressView()
                }
            }
            .preferredColorScheme(.dark)
            .task {
                do {
                    try await viewModel.loadData()
                } catch let error {
                    errorMessage = error.localizedDescription
                    alertPresent = true
                }
            }
            .alert("Oops, an error occurred: \(errorMessage)", isPresented: $alertPresent) { }
        }
        .navigationViewStyle(.stack)
    }
    
    
}

extension MainScreenView {
    private var tabView: some View {
        TabView {
            ForEach(viewModel.rockets) { rocket in
                RocketSubView(rocket: rocket)
            }
        }
        .tabViewStyle(.page)
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(ViewModel(dataManager: DataManager()))
    }
}

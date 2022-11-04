//
//  ContentView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 06.02.2022.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if !viewModel.rockets.isEmpty {
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
            .preferredColorScheme(.dark)
            .task {
                await viewModel.dataManager.loadData()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(ViewModel())
    }
}

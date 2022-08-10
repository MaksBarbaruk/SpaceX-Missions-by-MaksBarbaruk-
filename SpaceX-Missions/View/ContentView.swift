//
//  ContentView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 06.08.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if !viewModel.rockets.isEmpty {
                    TabView {
                        ForEach(viewModel.rockets) { rocket in
                            RocketView(rocket: rocket)
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
                await viewModel.loadData()
            }
        }
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

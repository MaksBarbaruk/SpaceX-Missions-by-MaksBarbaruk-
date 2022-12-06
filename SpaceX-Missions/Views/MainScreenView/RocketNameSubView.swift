//
//  RocketNameView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
//

import SwiftUI

struct RocketNameSubView: View {
    let rocket: Rocket
    
    @State private var showSettings = false
    
    var body: some View {
        HStack {
            Text(rocket.name)
                .accessibilityLabel("Rocket name: \(rocket.name)")
            
            Spacer()
            
            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape")
            }
            .accessibilityLabel("Settings")
        }
        .font(.title)
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

struct RocketNameView_Previews: PreviewProvider {
    static var previews: some View {
        RocketNameSubView(rocket: Rocket.example)
            .environmentObject(ViewModel(dataManager: DataManager()))
    }
}

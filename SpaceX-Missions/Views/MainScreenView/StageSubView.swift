//
//  StageView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
//

import SwiftUI

struct StageSubView: View {
    let stage: Rocket.Stage
    let stageNumberString: String
    
    var body: some View {
        VStack {
            stageNumberSection
            
            enginesSection
            fuelAmountSection
            
            if stage.burnTimeSec != nil {
                fuelBurnTimeSection
            }
        }
        .accessibilityElement(children: .combine)
    }
}

extension StageSubView {
    private var stageNumberSection: some View {
        HStack {
            Text(stageNumberString)
                .font(.title3)
                .textCase(.uppercase)
            
            Spacer()
        }
    }
    
    private var enginesSection: some View {
        HStack {
            Text("Engines")
                .font(.callout)
            Spacer()
            Text(stage.engines, format: .number)
                .font(.body)
        }
        .padding(.vertical, 5)
    }
    
    private var fuelAmountSection: some View {
        HStack {
            Text("Fuel amount")
                .font(.callout)
            Spacer()
            Text(stage.fuelAmountTons, format: .number)
                .font(.body)
            + Text(" ton")
        }
        .padding(.vertical, 5)
    }
    
    private var fuelBurnTimeSection: some View {
        HStack {
            Text("Fuel burn time")
                .font(.callout)
            Spacer()
            Text(stage.burnTimeSec ?? 0, format: .number)
                .font(.body)
            + Text(" sec")
                .font(.body)
        }
        .padding(.vertical, 5)
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageSubView(stage: Rocket.example.firstStage, stageNumberString: "First stage")
            .environmentObject(ViewModel(dataManager: DataManager()))
    }
}

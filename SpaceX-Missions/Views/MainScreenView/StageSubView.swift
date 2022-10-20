//
//  StageView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 07.02.2022.
//

import SwiftUI

struct StageSubView: View {
    let stage: Rocket.Stage
    let stageNumberString: String
    
    var body: some View {
        VStack {
            HStack {
                Text(stageNumberString)
                    .font(.title3)
                    .textCase(.uppercase)
                
                Spacer()
            }
            
            HStack {
                Text("Engines")
                    .font(.callout)
                Spacer()
                Text(stage.engines, format: .number)
                    .font(.body)
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("Fuel amount")
                    .font(.callout)
                Spacer()
                Text(stage.fuelAmountTons, format: .number)
                    .font(.body)
                + Text(" ton")
            }
            .padding(.vertical, 5)
            
            if stage.burnTimeSec != nil {
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
        .accessibilityElement(children: .combine)
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageSubView(stage: Rocket.example.firstStage, stageNumberString: "First stage")
            .environmentObject(ViewModel())
    }
}

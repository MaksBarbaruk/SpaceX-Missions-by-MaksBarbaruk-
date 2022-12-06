//
//  MoreAttributesView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
//

import SwiftUI

struct MoreAttributesSubView: View {
    let rocket: Rocket
    
    var body: some View {
        VStack {
            HStack {
                Text("First launch")
                    .font(.callout)
                Spacer()
                Text(rocket.firstFlight.formatted(date: .long, time: .omitted))
                    .font(.body)
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("Country")
                    .font(.callout)
                Spacer()
                Text(rocket.country)
                    .font(.body)
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("Launch cost")
                    .font(.callout)
                Spacer()
                Text(rocket.costPerLaunch, format: .currency(code: "USD").decimalSeparator(strategy: .always))
                    .font(.body)
            }
            .padding(.vertical, 5)
        }
        .accessibilityElement(children: .combine)
    }
}

struct MoreAttributesView_Previews: PreviewProvider {
    static var previews: some View {
        MoreAttributesSubView(rocket: Rocket.example)
            .environmentObject(ViewModel(dataManager: DataManager()))
    }
}

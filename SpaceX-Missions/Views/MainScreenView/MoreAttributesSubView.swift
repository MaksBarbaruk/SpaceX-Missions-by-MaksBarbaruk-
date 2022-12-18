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
            firstLaunchSection
            countrySection
            launchCostSection
        }
        .accessibilityElement(children: .combine)
    }
}

extension MoreAttributesSubView {
    private var firstLaunchSection: some View {
        HStack {
            Text("First launch")
                .font(.callout)
            Spacer()
            Text(rocket.firstFlight.formatted(date: .long, time: .omitted))
                .font(.body)
        }
        .padding(.vertical, 5)
    }
    
    private var countrySection: some View {
        HStack {
            Text("Country")
                .font(.callout)
            Spacer()
            Text(rocket.country)
                .font(.body)
        }
        .padding(.vertical, 5)
    }
    
    private var launchCostSection: some View {
        HStack {
            Text("Launch cost")
                .font(.callout)
            Spacer()
            Text(rocket.costPerLaunch, format: .currency(code: "USD").decimalSeparator(strategy: .always))
                .font(.body)
        }
        .padding(.vertical, 5)
    }
}

struct MoreAttributesView_Previews: PreviewProvider {
    static var previews: some View {
        MoreAttributesSubView(rocket: Rocket.example)
            .environmentObject(ViewModel(dataManager: DataManager()))
    }
}

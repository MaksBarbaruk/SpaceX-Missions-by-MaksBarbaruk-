//
//  MainAttributesView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 07.08.2022.
//

import SwiftUI

struct MainAttributesView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    let cornerRadius = 35.0
    let frameWidth = 100.0
    let frameHeight = 100.0
    let rocket: Rocket
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                VStack {
                    Text(rocket.getHeight(heightMetric: viewModel.metrics.heightMetric), format: .number)
                        .font(.title3.bold())
                    Text("Height, \(viewModel.metrics.heightMetric)")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .frame(width: frameWidth, height: frameHeight)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(rocket.getHeightAccessibilityLabel(heightMetric: viewModel.metrics.heightMetric))
                
                VStack {
                    Text(rocket.getDiameter(diameterMetric: viewModel.metrics.diameterMetric), format: .number)
                        .font(.title3.bold())
                    Text("Diameter, \(viewModel.metrics.diameterMetric)")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .frame(width: frameWidth, height: frameHeight)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(rocket.getDiameterAccessibilityLabel(diameterMetric: viewModel.metrics.diameterMetric))
                
                VStack {
                    Text(rocket.getMass(massMetric: viewModel.metrics.massMetric), format: .number)
                        .font(.title3.bold())
                    Text("Mass, \(viewModel.metrics.massMetric)")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .frame(width: frameWidth, height: frameHeight)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(rocket.getMassAccessibilityLabel(massMetric: viewModel.metrics.massMetric))
                
                VStack {
                    Text(rocket.getPayload(payloadMetric: viewModel.metrics.payloadMetric), format: .number)
                        .font(.title3.bold())
                    Text("Payload, \(viewModel.metrics.payloadMetric)")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .frame(width: frameWidth, height: frameHeight)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(rocket.getPayloadAccessibilityLabel(payloadMetric: viewModel.metrics.payloadMetric))
            }
        }
    }
}


struct MainAttributesView_Previews: PreviewProvider {
    static var previews: some View {
        MainAttributesView(rocket: Rocket.example)
            .environmentObject(ViewModel())
    }
}

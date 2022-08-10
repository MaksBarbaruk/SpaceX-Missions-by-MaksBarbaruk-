//
//  SettingsView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 08.08.2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Height")
                        .font(.title3.bold())
                        .accessibilityHidden(true)
                    
                    Spacer()
                    
                    Picker("Height", selection: $viewModel.metrics.heightMetric) {
                        ForEach(viewModel.metrics.heightAndDiameterMetrics, id: \.self) { metric in
                            Text(metric)
                                .accessibilityLabel(metric == "m" ?
                                                    "Height notation in meters" :
                                                        "Height notation in feets")
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100, height: 25)
                }
                .padding(.top, 30)
                
                HStack {
                    Text("Diameter")
                        .font(.title3.bold())
                        .accessibilityHidden(true)
                    
                    Spacer()
                    
                    Picker("Diameter", selection: $viewModel.metrics.diameterMetric) {
                        ForEach(viewModel.metrics.heightAndDiameterMetrics, id: \.self) { metric in
                            Text(metric)
                                .accessibilityLabel(metric == "m" ?
                                                    "Diameter notation in meters" :
                                                        "Diameter notation in feets")
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100, height: 25)
                }
                .padding(.top, 20)
                
                HStack {
                    Text("Mass")
                        .font(.title3.bold())
                        .accessibilityHidden(true)
                    
                    Spacer()
                    
                    Picker("Mass", selection: $viewModel.metrics.massMetric) {
                        ForEach(viewModel.metrics.massAndPayloadMetrics, id: \.self) { metric in
                            Text(metric)
                                .accessibilityLabel(metric == "kg" ?
                                                    "Mass notation in kilograms" :
                                                        "Mass notation in pounds")
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100, height: 25)
                }
                .padding(.top, 20)
                
                HStack {
                    Text("Payload")
                        .font(.title3.bold())
                        .accessibilityHidden(true)
                    
                    Spacer()
                    
                    Picker("Payload", selection: $viewModel.metrics.payloadMetric) {
                        ForEach(viewModel.metrics.massAndPayloadMetrics, id: \.self) { metric in
                            Text(metric)
                                .accessibilityLabel(metric == "kg" ?
                                                    "Payload notation in kilograms" :
                                                        "Payload notation in pounds")
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100, height: 25)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding(30)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    dismiss()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ViewModel())
    }
}

//
//  LaunchesView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 10.08.2022.
//

import SwiftUI

struct LaunchesView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    let rocket: Rocket
    var launches: [Launch] {
        return viewModel.launches.filter { $0.rocket == rocket.id }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ScrollView(showsIndicators: false) {
                    ForEach (launches) { launch in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(launch.name)
                                    .font(.title3.bold())
                                Text(launch.dateLocal.formatted(date: .long, time: .omitted))
                                    .font(.footnote)
                            }
                            .padding()
                            
                            Spacer()
                            
                            ZStack {
                                Image(launch.unwrappedSuccess ? "rocketUp" : "rocketDown")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .padding()
                                if launch.unwrappedSuccess {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.white, .green)
                                        .font(.caption.bold())
                                        .offset(x: 5, y: 5)
                                } else {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundStyle(.white, .red)
                                        .font(.caption.bold())
                                        .offset(x: 5, y: 5)
                                }
                            }
                        }
                        .frame(width: geometry.size.width * 0.8, height: 100)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding(.vertical, 5)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(launch.accessibilityLabel)
                        
                    }
                }
                .navigationBarTitle("Launches")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding(.horizontal, geometry.size.width * 0.2 / 2)
        }
        .background(.black)
        .preferredColorScheme(.dark)
    }
}

struct LaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesView(rocket: Rocket.example)
            .environmentObject(ViewModel(dataManager: DataManager()))
    }
}

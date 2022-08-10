//
//  RocketView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 07.08.2022.
//

import SwiftUI

struct RocketView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    let rocket: Rocket
    let cornerRadius = 35.0
    var imageUrl: URL? {
        return URL(string: rocket.flickrImages.randomElement() ?? "Unknown string")
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    .offset(y: -safeAreaInsets.top)
                    .accessibilityHidden(true)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer(minLength: (geometry.size.height / 3) - safeAreaInsets.top - cornerRadius * 2)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            RocketNameView(rocket: rocket)
                                .padding(.vertical, 16)
                            MainAttributesView(rocket: rocket)
                                .padding(.vertical, 16)
                            MoreAttributesView(rocket: rocket)
                                .padding(.vertical, 16)
                            StageView(stage: rocket.firstStage, stageNumberString: "First stage")
                                .padding(.vertical, 16)
                            StageView(stage: rocket.secondStage, stageNumberString: "Second stage")
                                .padding(.vertical, 16)
                            
                            NavigationLink {
                                LaunchesView(rocket: rocket)
                            } label: {
                                Text("Launches")
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.bottom, cornerRadius)
                        }
                        .padding(30)
                    }
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .padding(.top, 30)
                }
            }
        }
    }
}

struct RocketView_Previews: PreviewProvider {
    static var previews: some View {
        RocketView(rocket: Rocket.example)
            .preferredColorScheme(.dark)
            .environmentObject(ViewModel())
    }
}








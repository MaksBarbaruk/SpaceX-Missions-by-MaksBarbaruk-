//
//  RocketView.swift
//  SpaceX-Missions
//
//  Created by MaksBarbaruk on 07.02.2022.
//

import SwiftUI

struct RocketSubView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State private var imageUrl: URL? = URL(string: "")
    
    let rocket: Rocket
    let cornerRadius = 35.0
    var getNewImageUrl: URL? {
         URL(string: rocket.flickrImages.randomElement() ?? "Unknown string")
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                imageSection(geometry: geometry)
                    .onTapGesture {
                        imageUrl = getNewImageUrl
                    }
                
                VStack {
                    Spacer(minLength: (geometry.size.height / 3) - safeAreaInsets.top - cornerRadius * 2)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            RocketNameSubView(rocket: rocket)
                            MainAttributesSubView(rocket: rocket)
                            MoreAttributesSubView(rocket: rocket)
                            StageSubView(stage: rocket.firstStage, stageNumberString: "First stage")
                            StageSubView(stage: rocket.secondStage, stageNumberString: "Second stage")
                            
                            NavigationLink {
                                LaunchesView(rocket: rocket)
                            } label: {
                                Text("Launches")
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.bottom, cornerRadius)
                        }
                        .padding(.vertical, 16)
                        .padding(30)
                    }
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .padding(.top, 30)
                }
                .onAppear {
                    imageUrl = getNewImageUrl
                }
            }
        }
    }
}

extension RocketSubView {
    private func imageSection(geometry: GeometryProxy)-> some View {
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
    }
}

struct RocketView_Previews: PreviewProvider {
    static var previews: some View {
        RocketSubView(rocket: Rocket.example)
            .preferredColorScheme(.dark)
            .environmentObject(ViewModel(dataManager: DataManager()))
    }
}








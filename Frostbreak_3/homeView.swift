//
//  homeView.swift
//  Frostbreak_1
//
//  Created by Jose julian Lopez on 03/04/25.
//

import SwiftUI

struct homeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("HOME")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    
                    VStack(spacing: 15) {
                        VStack(alignment:.leading, spacing: 15) {
                            // Title1/Emphasized
                            HStack(alignment: .center) {
                                Text("¡Es hora de Enfriarse!")
                                    .font(.title.bold())
                                    .frame(width: 243, alignment: .topLeading)
                                    .kerning(0.38)
                                    .foregroundColor(.white)
                                Spacer()
                                Image("Noti")
                                    .shadow(color: Color(red: 0, green: 0.68, blue: 0.7).opacity(0.4), radius: 8.0, x: 0, y: 4)
                            }
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 2)
                                .background(.white.opacity(0.4))
                        }
                        .padding(.horizontal, 24)
                        
                        Image("Iceberg")
                    }
                    
                    VStack(alignment: .center, spacing: 24) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("00:00!")
                                .font(.title.bold())
                        }
                        .padding(23)
                        .frame(width: 150, height: 60, alignment: .center)
                        .background(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.00),
                                        Gradient.Stop(color: .white, location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: -0.57, y: 0.5),
                                    endPoint: UnitPoint(x: 1.68, y: 0.5)
                                ).opacity(0.49), lineWidth: 2)
                        )
                        
                        // Updated NavigationLink to point to ExerciseTimerView2
                        NavigationLink(destination: ExerciseTimerView2()) {
                            VStack(alignment: .center, spacing: 12) {
                                Text("Descanzar")
                                    .font(.title3).fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 35)
                            .padding(.vertical, 12)
                            .frame(width: 194, height: 65, alignment: .center)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.76, green: 0.43, blue: 0.92), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.11, green: 0.34, blue: 0.75), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                            .cornerRadius(24)
                            .shadow(color: Color(red: 0, green: 0.68, blue: 0.7).opacity(0.35), radius: 2.85, x: 0, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .inset(by: 1)
                                    .stroke(LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.00),
                                            Gradient.Stop(color: .white, location: 1.00),
                                        ],
                                        startPoint: UnitPoint(x: -0.57, y: 0.5),
                                        endPoint: UnitPoint(x: 1.68, y: 0.5)
                                    ).opacity(0.3).blendMode(.plusLighter), lineWidth: 3
                                )
                            )
                        }
                    }
                }
                .padding(.top, 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    homeView()
}


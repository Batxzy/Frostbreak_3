//
//  ActivityView.swift
//  Frostbreak_1
//
//  Created by Jose julian Lopez on 03/04/25.
//

import SwiftUI

struct ExerciseTimerView: View {
    var body: some View {
        ZStack {
            
            Image("HOME")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            VStack(spacing: 26) {
                
                VStack(alignment: .center, spacing: -18) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "xmark")
                                .font(.system(size: 24))
                                .foregroundColor(.white.opacity(0.70))
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "speaker.wave.2")
                                .font(.system(size: 24))
                                .foregroundColor(.white.opacity(0.70))
                        }
                    }
                    
                    VStack(alignment: .center, spacing: 16) {
                        
                            VStack(alignment: .center) {
                                Text("11:00")
                                    .font(.largeTitle).bold()
                            }
                                .padding(0)
                                .frame(width: 204, height: 86, alignment: .center)
                                .background(
                                    LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: Color(red: 0.02, green: 0.73, blue: 0.74), location: 0.00),
                                            Gradient.Stop(color: Color(red: 0.01, green: 0.1, blue: 0.34), location: 1.00),
                                        ],
                                        startPoint: UnitPoint(x: 0.72, y: -0.64),
                                        endPoint: UnitPoint(x: 0.72, y: 2.07)
                                    ).opacity(0.37)
                                )
                                .cornerRadius(60)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 60)
                                        .inset(by: 1)
                                        .stroke(LinearGradient(
                                            stops: [
                                                Gradient.Stop(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.00),
                                                Gradient.Stop(color: .white, location: 1.00),
                                            ],
                                            startPoint: UnitPoint(x: -0.57, y: 0.5),
                                            endPoint: UnitPoint(x: 1.68, y: 0.5)
                                        ).opacity(0.3).blendMode(.plusLighter),lineWidth: 2)
                            )
                            HStack(spacing: 10) {
                                ForEach(0..<7) { index in
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(index == 0 ? Color.white : Color.gray)
                                        .frame(width: 8, height: 8)
                                        }
                                    }
                                .frame(height: 24)
                                .padding(.horizontal, 10)
                                .background(Material.thick)
                                .cornerRadius(25)
                            
                            Text("Siguiente ejercicio: 20/20/20")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        
                        }
                    }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .top)
                        .background(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))

                        .cornerRadius(37)
                        .overlay(
                        RoundedRectangle(cornerRadius: 37)
                        .inset(by: 0.5)
                        .stroke(LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.00),
                                Gradient.Stop(color: .white, location: 1.00),
                            ],
                            startPoint: UnitPoint(x: -0.57, y: 0.5),
                            endPoint: UnitPoint(x: 1.68, y: 0.5)
                        ).opacity(0.3).blendMode(.plusLighter), lineWidth: 2)

                        )
               
                    VStack(alignment: .leading) {
                    // Space Between
                        Text("Veo veo")
                            .font(.largeTitle)
                    Spacer()
                    // Alternating Views and Spacers
                        VStack(alignment: .center, spacing: 10) {
                            Text("1:00")
                                .font(.system(size: 22, weight: .bold))
                        }
                        .padding(10)
                        .frame(width: 129, alignment: .center)
                        .background(Color(red: 0.23, green: 0.23, blue: 0.23))

                        .cornerRadius(50)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, minHeight: 377, maxHeight: 377, alignment: .leading)
                    .background(.black)

                    .cornerRadius(14)
                
                Button(action: {}) {
                    Text("Siguiente")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 40)
                        .background(
                            Capsule()
                                .fill(Color.white)
                        )
                }
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ExerciseTimerView()
}

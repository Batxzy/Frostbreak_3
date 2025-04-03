//
//  ButtonsView.swift
//  Frostbreak
//
//  Created by Jose julian Lopez on 03/04/25.
//

import SwiftUI


struct ButtonsView: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: "figure.cooldown")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                  
            }
            .padding(0)
            .frame(width: 77, height: 76, alignment: .center)
            .background(Constants.LabelsQuaternary)
            .cornerRadius(60)
            .overlay(
              RoundedRectangle(cornerRadius: 60)
                .inset(by: 0.5)
                .stroke(Color(red: 0.04, green: 0.04, blue: 0.04), lineWidth: 1)
            )
            
            VStack(alignment: .leading, spacing: 6) {
                // Headline/Regular
                Text("sdfdsfs")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                // Footnote/Regular
                Text("dsf")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.02, green: 0.73, blue: 0.74), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.01, green: 0.1, blue: 0.34), location: 1.00),
            ],
                startPoint: UnitPoint(x: 0.5, y: 1),
                endPoint: UnitPoint(x: 0.5, y: 0)
            )
            .opacity(0.33)
        )
        .cornerRadius(24)
        .overlay(
          RoundedRectangle(cornerRadius: 24)
            .inset(by: 0.5)
            .stroke(LinearGradient(
                stops: [
                Gradient.Stop(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.00),
                Gradient.Stop(color: .white, location: 1.00),
                ],
                startPoint: UnitPoint(x: -0.57, y: 0.5),
                endPoint: UnitPoint(x: 1.68, y: 0.5)
            ).opacity(0.49), lineWidth: 1)
        )
    }
}


#Preview {
    ButtonsView()
}


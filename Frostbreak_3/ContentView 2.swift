//
//  ContentView.swift
//  Frostbreak
//
//  Created by Jose julian Lopez on 03/04/25.
//

import SwiftUI


struct Exercise: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct ExercisesView: View {
    @State private var selectedCategory = 0
    
    let categories = ["Eye", "Body"]
    
    let exercises = [
        Exercise(
            title: "Ejercicio 20 20",
            description: "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit."
        ),
        Exercise(
            title: "Ejercicio 20 20",
            description: "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit."
        ),
        Exercise(
            title: "Ejercicio 20 20",
            description: "Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit."
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Segmented Control
                Picker("Category", selection: $selectedCategory) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        Text(categories[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Exercises List
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(exercises.indices, id: \.self) { index in
                            ExerciseRow(exercise: exercises[index])
                            
                            if index != exercises.count - 1 {
                                Divider()
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Ejercicios")
        }
    }
}

struct Constants {
  static let LabelsQuaternary: Color = Color(red: 0.92, green: 0.92, blue: 0.96).opacity(0.16)
}




struct ExerciseRow: View {
    let exercise: Exercise
    
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
                Text(exercise.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                // Footnote/Regular
                Text(exercise.description)
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
    ExercisesView()
}

//
//  ExercizeView.swift
//  Frostbreak_1
//
//  Created by Jose julian Lopez on 03/04/25.
//

import SwiftUI

import SwiftUI

struct ExercizeView: View {
    @State private var selectedTab: Tab = .eye
    
    enum Tab {
        case eye
        case body
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 25)  {
                CustomTabBar(selectedTab: $selectedTab)
                TabView(selection: $selectedTab) {
                    ExercisesView1(category: "Eye")
                        .tag(Tab.eye)
                    
                    ExercisesView2(category: "Body")
                        .tag(Tab.body)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .navigationTitle("Ejercicios")
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: ExercizeView.Tab
    
    var body: some View {
        HStack(spacing: 0) {
            // Eye Tab Button
            Button(action: {
                selectedTab = .eye
            }) {
                HStack {
                    Spacer()
                    Text("Eye")
                        .font(.subheadline.bold())
                        .foregroundColor(selectedTab == .eye ? .white : .gray)
                    Spacer()
                }
                .padding(8)
                .background(selectedTab == .eye ? Color.gray.opacity(0.5) : Color.clear)
                .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
            
            // Body Tab Button
            Button(action: {
                selectedTab = .body
            }) {
                HStack {
                    Spacer()
                    Text("Body")
                        .font(.subheadline.bold())
                        .foregroundColor(selectedTab == .body ? .white : .gray)
                    Spacer()
                }
                .padding(8)
                .background(selectedTab == .body ? Color.gray.opacity(0.5) : Color.clear)
                .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.2))
        .cornerRadius(100)
        .padding(.horizontal, 16)
    }
}



struct ExercisesView1: View {
    let category: String
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
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(exercises.indices, id: \.self) { index in
                        ExerciseRow1(exercise: exercises[index])
                        
                        if index != exercises.count - 1 {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

struct ExercisesView2: View {
    let category: String
    @State private var selectedCategory = 0
    
    let categories = ["Eye", "Body"]
    
    let exercises = [
        Exercise(
            title: "Ejercicio 20 fds",
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
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(exercises.indices, id: \.self) { index in
                        ExerciseRow1(exercise: exercises[index])
                        
                        if index != exercises.count - 1 {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

struct ExerciseRow1: View {
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
                .stroke(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.00),
                            Gradient.Stop(color: .white, location: 1.00),
                        ],
                        startPoint: UnitPoint(x: -0.57, y: 0.5),
                        endPoint: UnitPoint(x: 1.68, y: 0.5)
                    ).opacity(0.49), lineWidth: 1)
            )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(exercise.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
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
            .stroke(
                LinearGradient(
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
    ExercizeView()
}

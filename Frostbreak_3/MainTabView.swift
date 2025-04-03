//
//  MainTabView.swift
//  Frostbreak_1
//
//  Created by Jose julian Lopez on 03/04/25.
//


import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    init() {
            // Configure the UITabBar appearance for all tab bars
            let tabBarAppearance = UITabBarAppearance()
            
            // Use thick material
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemThickMaterial)
            
            // Remove the tab bar line
            tabBarAppearance.shadowColor = .clear
            
            // Make sure the tab bar is visible
            tabBarAppearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
            
            // Apply the appearance to all states (normal, scrolled)
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            // First Tab
            homeView(tabSelection: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            // Second Tab
            ExercizeView()
                .tabItem {
                    Label("Explore", systemImage: "waveform.path.ecg")
                }
                .tag(1)
            
            // Third Tab
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(2)
        }
    }
}

// Content views for each tab

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile Screen")
                    .font(.largeTitle)
            }
            .navigationTitle("Profile")
        }
    }
}

struct homeView: View {
    @Binding var tabSelection: Int
    
    // For preview only
    init(tabSelection: Binding<Int>? = nil) {
        self._tabSelection = tabSelection ?? Binding.constant(0)
    }
    
    var body: some View {
        NavigationView {
            // Existing view content...
            
            // Modify the NavigationLink to pass tab selection
            NavigationLink(destination: ExerciseTimerView2(tabSelection: $tabSelection)) {
                // Button content remains the same
                VStack(alignment: .center, spacing: 12) {
                    Text("Descanzar")
                        .font(.title3).fontWeight(.bold)
                        .foregroundColor(.white)
                }
                // ...button styling remains the same
            }
        }
    }
}

struct ExerciseTimerView2: View {
    @State private var viewModel = ExerciseTimerViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var soundOn = true
    @Binding var tabSelection: Int
    
    // For preview only
    init(tabSelection: Binding<Int>? = nil) {
        self._tabSelection = tabSelection ?? Binding.constant(0)
    }
    
    var body: some View {
        // Existing view content...
        
        .alert("¡Ejercicios completados!", isPresented: $viewModel.showCompletionAlert) {
            Button("OK") {
                dismiss()
                tabSelection = 0 // Ensure we return to home tab
            }
        } message: {
            Text("Has completado todos los ejercicios de descanso visual y estiramientos.")
        }
    }
}

#Preview(){
    MainTabView()
}

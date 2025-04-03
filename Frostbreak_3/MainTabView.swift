//
//  MainTabView.swift
//  Frostbreak_1
//
//  Created by Jose julian Lopez on 03/04/25.
//


import SwiftUI

struct MainTabView: View {
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
        
        TabView {
            // First Tab
            homeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Second Tab
            ExercizeView()
                .tabItem {
                    Label("Explore", systemImage: "waveform.path.ecg")
                }
            
            // Third Tab
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
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

#Preview(){
    MainTabView()
}

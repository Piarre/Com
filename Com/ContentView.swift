//
//  ContentView.swift
//  Com
//
//  Created by Pierre Idé on 09/07/2023.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Home", systemImage: "wave.3.right")
                    
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
//        .onAppear {
//            let appearance = UIToolbarAppearance()
//            
//            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
//            appearance.backgroundColor = UIColor(Color.gray.opacity(0.1))
//            
//            UIToolbar.appearance().standardAppearance = appearance
//            UIToolbar.appearance().scrollEdgeAppearance = appearance
//        }
    }
}

#Preview {
    ContentView()
}

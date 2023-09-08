//
//  WriteView.swift
//  Com
//
//  Created by Pierre Idé on 10/07/2023.
//

import SwiftUI

struct WriteView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    PhoneWriteView()
                } label: {
                    Label("Phone", systemImage: "phone")
                }
                
                NavigationLink {
                    TextWriteView()
                } label: {
                    Label("Text", systemImage: "phone")
                }
                
                NavigationLink {
                    // TODO:
                } label: {
                    Label("Message", systemImage: "message")
                }
                
                NavigationLink {
                    // TODO:
                } label: {
                    Label("Contact", systemImage: "person")
                }
                
                NavigationLink {
                    // TODO:
                } label: {
                    Label("Wifi", systemImage: "wifi")
                }
                
                // TODO: Social
            }
            .navigationTitle("Write")
        }
    }
}

#Preview {
    WriteView()
}

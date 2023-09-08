//
//  PhoneWriteView.swift
//  Com
//
//  Created by Pierre Idé on 13/07/2023.
//

import SwiftUI

struct PhoneWriteView: View {
    let nfcWriter = NFCWriter()
    @State private var phoneNumber: String = "";
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .focused($isFocused)
            }
            .navigationTitle("Phone number")
            .toolbar {
                ToolbarItem {
                    Button {
                        nfcWriter.write(payload: self.phoneNumber, payloadType: .phoneNumber)
                    } label: {
                        Label("Write", systemImage: "wave.3.right")
                    }
                }
            }
        }
        //        .onAppear {
        //            self.isFocused = true
        //        }
    }
}

#Preview {
    PhoneWriteView()
}

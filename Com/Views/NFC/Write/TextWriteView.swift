//
//  TextWriteView.swift
//  Com
//
//  Created by Pierre Idé on 24/07/2023.
//

import SwiftUI

struct TextWriteView: View {
    let nfcWriter = NFCWriter()
    @State private var text: String = "";
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Text", text: $text) 
                    .focused($isFocused)
            }
            .navigationTitle("Text")
            .toolbar {
                ToolbarItem {
                    Button {
                        nfcWriter.write(payload: self.text, payloadType: .text)
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
    TextWriteView()
}

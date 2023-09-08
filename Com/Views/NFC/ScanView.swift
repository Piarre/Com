//
//  ScanView.swift
//  Com
//
//  Created by Pierre Idé on 10/07/2023.
//

import SwiftUI

struct ScanView: View {
    @StateObject private var nfcScanner = NFCReader.shared
    
    @State private var pulseOpacity: CGFloat = 0.0
    @State private var isScanned = false
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                PulsatingView(y: -420, opacity: pulseOpacity)
                //                HStack(spacing: 20) {
                //                    VStack(alignment: .leading) {
                //                        Text("Payload")
                //                            .font(.title).bold()
                //
                //                        Text("\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq\ndqsdqdq sd qsdqsd pifhgqsitdgfqi dfq")
                //                            .font(.body)
                //                    }
                //                    .frame(maxWidth: .infinity, alignment: .leading)
                //                    .frame(height: )
                //                }
                //                .ignoresSafeArea()
                //                .padding()
            }
            //            .navigationTitle("Scanner")
            //            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                startScan()
                self.isScanned = true
            }
        }
    }
    
    func startScan() {
        nfcScanner.startSession()
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            self.pulseOpacity = 1.0
        }
    }
    
    func stopScan() {
        nfcScanner.isScanning = false
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            self.pulseOpacity = 0.0
        }
    }
}

#Preview {
    ScanView()
}

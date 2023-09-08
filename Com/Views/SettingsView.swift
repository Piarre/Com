//
//  SettingsView.swift
//  Com
//
//  Created by Pierre Idé on 09/07/2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var nfcRead = NFCReader.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Scans") {
                        NavigationLink {
                            ScanHistoryView(scans: nfcRead.scans)
                        } label: {
                            Label("Scan History", systemImage: "arrow.triangle.2.circlepath")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
}

struct HText: View {
    var property: String = "";
    var value: String = "";
    
    var body: some View {
        HStack {
            Text(property)
                .foregroundColor(.accentColor)
            Spacer()
            Text(value)
        }
    }
}

struct ScanHistoryView: View {
    @State var scans: [Scan] = []
    @StateObject private var nfcRead = NFCReader.shared
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    var body: some View {
        List {
            ForEach(scans) { scan in
                HStack {
                    Text(scan.payload)
                        .foregroundColor(scan.isError ? .red : .primary)
                    Spacer()
                    Text(dateFormatter.string(from: scan.date))
                        .font(.caption)
                }
            }
        }
        .navigationTitle("Scan History")
        .onChange(of: scans, {
            nfcRead.loadSavedScans()
        })
        .toolbar {
            ToolbarItem {
                Button {
                    nfcRead.scans.removeAll()
                    scans.removeAll()
                } label: {
                    Label("Clear scan history", systemImage: "trash")
                        .foregroundStyle(Color.red)
                }
            }
        }
//        .disabled(true)
    }
}

#Preview {
    SettingsView()
}

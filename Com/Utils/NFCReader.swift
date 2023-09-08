//
//  NFCReader.swift
//  Com
//
//  Created by Pierre Idé on 10/07/2023.
//

import Foundation
import CoreNFC

class NFCReader: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    private var nfcSession: NFCNDEFReaderSession?
    static let shared = NFCReader()
    @Published var scans: [Scan] = []
    
    override init() {
        super.init()
        self.loadSavedScans()
    }
    
    @Published var payload: String = ""
    @Published var isScanning: Bool = false
    
    func startSession() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("Does not support NFC read/write.")
            
            let lastScan = Scan(payload: "Does not support NFC read/write.", isError: true, date: Date())
            
            self.scans.append(lastScan)
            self.logScan(lastScan)
            return
        }
        
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        nfcSession?.begin()
        isScanning = true
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // MARK: Useless
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let payloadData = messages.first?.records.first?.payload else {
            print("No NDEF data found")
        
            let lastScan = Scan(payload: "No NDEF data found", isError: true, date: Date())
            
            DispatchQueue.main.async {
                self.scans.append(lastScan)
                self.logScan(lastScan)
                session.invalidate()
                self.isScanning = false
            }
        
            return
        }
        
        let payloadString = String(data: payloadData, encoding: .utf8) ?? ""
        
        let lastScan = Scan(payload: payloadString, isError: false, date: Date())
        
        DispatchQueue.main.async {
            self.payload = payloadString
            self.scans.append(lastScan)
            self.logScan(lastScan)
            session.invalidate()
            self.isScanning = false
        }
    }
    
    public func logScan(_ scan: Scan) {
        var savedScans = UserDefaults.standard.array(forKey: "SavedScans") as? [Data] ?? []
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(scan) {
            savedScans.append(encodedData)
            UserDefaults.standard.set(savedScans, forKey: "SavedScans")
        }
    }
    
    public func loadSavedScans() {
        if let savedScanData = UserDefaults.standard.array(forKey: "SavedScans") as? [Data] {
            let decoder = JSONDecoder()
            for data in savedScanData {
                if let scan = try? decoder.decode(Scan.self, from: data) {
                    self.scans.append(scan)
                }
            }
        }
    }
}

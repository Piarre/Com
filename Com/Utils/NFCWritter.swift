//
//  NFCWritter.swift
//  Com
//
//  Created by Pierre Idé on 13/07/2023.
//

import Foundation
import CoreNFC

enum PayloadType {
    case text, url, phoneNumber
}

class NFCWriter: NSObject, NFCNDEFReaderSessionDelegate {
    var nfcSession: NFCNDEFReaderSession?
    var payload = ""
    var payloadType: PayloadType = .text
    
    func write(payload: String, payloadType: PayloadType) {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("La lecture NFC n'est pas disponible sur cet appareil.")
            return
        }
        
        self.payload = payload
        self.payloadType = payloadType
        
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        nfcSession?.alertMessage = "Approchez votre iPhone de la puce NFC."
        nfcSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("La session NFC a été invalidée avec l'erreur : \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        if tags.count > 1 {
            let retryInterval = DispatchTimeInterval.milliseconds(2000)
            session.alertMessage = "Mort than 1 tag is detected."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                session.restartPolling()
            }
            
            return
        }
        
        let tag = tags.first!
        session.connect(to: tag) { (error) in
            if let error = error {
                session.alertMessage = "Unable to connect to tag."
                session.invalidate()
                return
            }
            
            tag.queryNDEFStatus{ (NDEFStatus, capacity, error) in
                if let error = error {
                    session.alertMessage = "Unable to query the tag."
                    session.invalidate()
                    return
                }
                
                switch NDEFStatus {
                case .notSupported:
                    session.alertMessage = "Tag not supported."
                    session.invalidate()
                case .readOnly:
                    session.alertMessage = "Tag is in read only."
                    session.invalidate()
                    
                case .readWrite:
                    let _: NFCNDEFPayload?
                    switch self.payloadType {
                    case .text:
                        let payload = NFCNDEFPayload(format: .nfcWellKnown,
                                                     type: "T".data(using: .utf8)!,
                                                     identifier: Data(),
                                                     payload: self.payload.data(using: .utf8)!)
                        tag.writeNDEF(NFCNDEFMessage(records: [payload])) { (error) in
                            if error != nil {
                                session.alertMessage = "Failed to write text payload to tag."
                            } else {
                                session.alertMessage = "Text payload written successfully."
                            }
                            session.invalidate()
                        }
                    case .url:
                        guard let url = URL(string: self.payload) else {
                            session.alertMessage = "Invalid URL."
                            session.invalidate()
                            return
                        }
                        let payload = NFCNDEFPayload.wellKnownTypeURIPayload(url: url)!
                        tag.writeNDEF(NFCNDEFMessage(records: [payload])) { (error) in
                            print(payload)
                            if error != nil {
                                session.alertMessage = "Failed to write URL payload to tag."
                            } else {
                                session.alertMessage = "URL payload written successfully."
                            }
                            session.invalidate()
                        }
                    case .phoneNumber:
                        let payload = NFCNDEFPayload(format: .nfcWellKnown,
                                                     type: Data(),
                                                     identifier: Data(),
                                                     payload: self.payload.data(using: .utf8)!)
                        tag.writeNDEF(NFCNDEFMessage(records: [payload])) { (error) in
                            if error != nil {
                                session.alertMessage = "Failed to write text payload to tag."
                            } else {
                                session.alertMessage = "Text payload written successfully."
                            }
                            session.invalidate()
                        }
                    }
                @unknown default:
                    session.alertMessage = "Unknown error."
                    session.invalidate()
                }
                
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs tags: [NFCNDEFMessage]) {
        
    }
}

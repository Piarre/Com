//
//  Scan.swift
//  Com
//
//  Created by Pierre Idé on 10/07/2023.
//

import Foundation

struct Scan: Codable, Identifiable, Equatable {
    var id = UUID()
    
    let payload: String
    let isError: Bool
    let date: Date
    
    static func ==(lhs: Scan, rhs: Scan) -> Bool {
        return lhs.payload == rhs.payload &&
        lhs.isError == rhs.isError &&
        lhs.date == rhs.date
    }
}

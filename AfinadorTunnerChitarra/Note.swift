//
//  Note.swift
//  AfinadorTunnerChitarra
//
//  Created by Martin alonso Gamboa on 21.04.2021.
//

import Foundation
import UIKit

class Note: Equatable {
    
    enum Accidental: Int { case natural = 0, sharp, flat }
    enum Name: Int {case A = 0, B, C, D, E, F, G }
    
    static let all: [Note] = [
        Note(.C, .natural),
        Note(.C, .sharp),
        Note(.D, .natural),
        Note(.E, .flat),
        Note(.E, .natural),
        Note(.F, .natural),
        Note(.F, .sharp),
        Note(.G, .natural),
        Note(.A, .flat),
        Note(.A, .natural),
        Note(.B, .flat),
        Note(.B, .natural)
    ]
    
    var note: Name
    var accidental: Accidental
    
    // Initializer.

    init(_ note: Name, _ accidental: Accidental) {
        self.note = note
        self.accidental = accidental
        
    }
    
    // Equality operators
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.note == rhs.note && lhs.accidental == rhs.accidental
    

    }
    static func !=(lhs: Note, rhs: Note) -> Bool {
        return !(lhs == rhs)
    }
    var frequency: Double {
        let index = Note.all.firstIndex(of: self)! - Note.all.firstIndex(of: Note(.A, .natural))!
        return 440.0 * pow(2.0, Double(index) / 12.0)
    }
}
    

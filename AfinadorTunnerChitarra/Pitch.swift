//
//  Pitch.swift
//  AfinadorTunnerChitarra
//
//  Created by Martin alonso Gamboa on 21.04.2021.
//

import Foundation


class Pitch {
        let frequency: Double
        let note: Note
        let octave: Int
        
        private init(note: Note, octave: Int) {
            self.note = note
            self.octave = octave
            self.frequency = note.frequency * pow(2.0, Double(octave) - 4.0)
            
            print(self.frequency)
        }
        
        
static let all = Array((0...8).map {octave -> [Pitch] in
Note.all.map {note ->
        Pitch in Pitch(note: note, octave: octave)
    
}

}).joined()
     
static func makePitchByFrequency(_ frequency: Double) -> Pitch {
            
var results = all.map { pitch -> (pitch: Pitch, distance: Double) in
                (pitch: pitch, distance: abs(pitch.frequency - frequency))
            }
            results.sort {$0.distance < $1.distance}
            return results.first!.pitch
            
        }
        
        
    }
    

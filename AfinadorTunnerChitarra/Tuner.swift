//
//  Tuner.swift
//  AfinadorTunnerChitarra
//
//  Created by Martin alonso Gamboa on 21.04.2021.
//

import Foundation
import AudioKit


class Tuner {
    var mic: AKMicrophone
    var tracker: AKFrequencyTracker
    var silence: AKBooster
    
    let pollingInterval = 0.05
    var pollingTimer: Timer?
    
    var delegate: TunerDelegate?
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.record, mode: .measurement, options: [])
        
        } catch let error {
            print(error.localizedDescription)
        }
       
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()!
        tracker = AKFrequencyTracker.init(mic)
        silence = AKBooster(tracker, gain: 0)
        AKManager.output = silence
    }
     
    func start() {
        
        
        do {
            try AKManager.start()
        } catch let error {
            print(error.localizedDescription)
        }
        pollingTimer = Timer.scheduledTimer(withTimeInterval: pollingInterval, repeats: true, block: { (_) in self.pollingTick() })
        
    }
 
    func stop() {
        do {
            try AKManager.stop()
        } catch let error {
            print(error.localizedDescription)
        }
        if let t = pollingTimer {
            t.invalidate()
        }
        
    }
    var returnNote = Note.Name(rawValue: 0)
    var returnAccidental = Note.Accidental(rawValue: 0)
    
    private func pollingTick() {
        let frequency = Double(tracker.frequency)
        let pitch = Pitch.makePitchByFrequency(frequency)
        let errRatio = frequency / pitch.frequency
        returnNote = pitch.note.note
        returnAccidental = pitch.note.accidental
        
        if let d = delegate {
            d.tunerDidTick(pitch: pitch, errRatio: errRatio)
            
        }
    }
    
    
    func getNote() -> String {
        var accidental = ""
        switch returnAccidental {
        
        case .natural:
            accidental = "Ok"
        case .flat :
            accidental = "♭"
        case .sharp:
            accidental = "♯"
        default:
            break
        }
        let noteString = "\(returnNote ?? Note.Name.A) \(accidental)"
        return noteString
    }
    
}

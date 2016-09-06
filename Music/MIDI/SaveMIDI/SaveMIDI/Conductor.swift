//
//  Conductor.swift
//  SaveMIDI
//
//  Created by Tommy Trojan on 9/5/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//
//  Solution:
//      http://stackoverflow.com/questions/13847580/ios-record-a-midi-file

import AudioKit
import AudioToolbox

class Conductor {
    private var sequence: AKSequencer?
    private var padVolume: AKBooster?
    private var mixer = AKMixer()

    var currentTempo = 120.0
    
    init(){
        padVolume?.gain = 1
        mixer.connect(padVolume!)

        sequence = AKSequencer(filename: "MySong", engine: AudioKit.engine)
        //sequence!.avTracks[1].destinationAudioUnit = padSynthesizer.samplerUnit
        //sequence!.setLength(AKDuration(beats: 4))
        ///sequence?.sequenceFromData(<#T##data: NSData##NSData#>)
        
        sequence?.setTempo(currentTempo)
    }
    
    //MARK: - https://gist.github.com/jcosentino11/4efe2afa6ecdc2eee7b2
    func save(){
        let directory = NSSearchPathDirectory.DocumentDirectory
        let domainMask = NSSearchPathDomainMask.UserDomainMask
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(directory, domainMask, true).first!
        
        let path = "MyMIDI.mid"
        let nsURL = NSURL(fileURLWithPath: documentsDirectory).URLByAppendingPathComponent(path).filePathURL
        if let fileURL = nsURL {
            debugPrint(path)
            let typeId = MusicSequenceFileTypeID.MIDIType
            let flags = MusicSequenceFileFlags.EraseFile
            let status = MusicSequenceFileCreate(sequence, fileURL as CFURL, typeId, flags, 0)
            if status != noErr {
                debugPrint(status)
            }
        }
    }
    
    func adjustVolume(volume: Float, instrument: Instrument) {
        switch instrument {
        case Instrument.Pad:
            padVolume?.gain = Double(volume)
        }
    }
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0 ? true : false
    }
    
    func increaseTempo() {
        currentTempo += 1.0
        sequence!.setTempo(currentTempo)
    }
    
    func decreaseTempo() {
        currentTempo -= 1.0
        sequence!.setTempo(currentTempo)
    }

}

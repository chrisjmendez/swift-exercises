//
//  Conductor.swift
//  SoundFont
//
//  Created by Tommy Trojan on 10/19/16.
//  Copyright © 2016 USC Radio Group. All rights reserved.
//
import AudioKit

class Conductor {
 
    var sampler = AKSampler()
    var soundFontSample = "SF2/AcousticGuitar"
    
    init() {
        //print("Conductor.init")
        sampler.loadMelodicSoundFont(soundFontSample, preset: 0)

        AudioKit.output = sampler
        AudioKit.start()
    }

    func play(note: Int, velocity: Int, duration: Float){
        //print("Conductor.play")
        sampler.play(noteNumber: note, velocity: velocity, channel: 0)
    }
}

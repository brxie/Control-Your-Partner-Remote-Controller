//
//  AudioPlayer.swift
//  control_your_woman
//
//  Created by Marcin on 12.03.2016.
//  Copyright © 2016 Marcin. All rights reserved.
//
import AVFoundation


public class AudioPlayer {
    
    private var audioFilesType = "mp3"
    private var sound: AVAudioPlayer?
    
    // setup audio player
    private func setupAudioPlayer(file:NSString) -> AVAudioPlayer?  {
        if file == "" {
           return nil
        }
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: self.audioFilesType as String)
        if path == nil {
            print("\(file) dont exist")
            return nil
        }
        let url = NSURL.fileURLWithPath(path!)
        var audioPlayer:AVAudioPlayer?
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        return audioPlayer
    }
    
    public func play(fileBaseName: NSString) {
        self.sound = self.setupAudioPlayer(fileBaseName)
        if (self.sound != nil) {
            self.sound!.play()
        }
    }
    
    public func prepareToPlay(audioFile: String) {
        if let butonSound = self.setupAudioPlayer(audioFile) {
            butonSound.prepareToPlay()
        }
    }
}
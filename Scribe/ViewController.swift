//
//  ViewController.swift
//  Scribe
//
//  Created by the Luckiest on 6/23/17.
//  Copyright © 2017 the Luckiest. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var trascribtionTextView: UITextView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var audioPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activitySpinner.isHidden = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    func requestSpeachAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        
                        sound.play()
                    } catch {
                        print("ERROR")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                        if let error = error {
                            print("There was an Error \(error)")
                        } else {
                            self.trascribtionTextView.text = result?.bestTranscription.formattedString ?? "No Result"
                        }
                    })
                }
            }
        }
    }
    
    
    
    
    @IBAction func playBtnTapped(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeachAuth()
    }
    
}


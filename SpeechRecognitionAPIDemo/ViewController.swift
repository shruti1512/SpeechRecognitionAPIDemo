//
//  ViewController.swift
//  SpeechRecognitionAPIDemo
//
//  Created by Shruti Sharma on 2/20/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class ViewController: UIViewController {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var speechTextView: UITextView!
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitySpinner.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //1. REQUEST SPEECH RECOGNITION AUTHORIZATION FROM USER
    func requestSpeechAuth() {

        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                self.attemptAudioToSpeechAnalysis()
            }
            else {
                print("User denied permission for speech recognition")
            }
        }
    }
    
    //2. CONVERT SPEECH TO TEXT
    func attemptAudioToSpeechAnalysis() {
        
        guard let audioFileURL = Bundle.main.url(forResource: "test", withExtension: "m4a") else {
            fatalError("Audio file does not exist.")
        }

        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioFileURL)
            audioPlayer.delegate = self
            audioPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        //. Create SFSpeechRecognizer object
        //. Create SFSpeechURLRecognitionRequest object
        //. Add recognitionTask using request on recogniser
        let recogniser = SFSpeechRecognizer()
        
        let request = SFSpeechURLRecognitionRequest(url: audioFileURL)
        recogniser?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            else {
                print(result?.bestTranscription.formattedString)
                self.speechTextView.text = result?.bestTranscription.formattedString
            }
        })
    }

    @IBAction func playAudioBtnTapEvent(_ sender: Any) {
        
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        
        requestSpeechAuth()
    }

}

extension ViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
}




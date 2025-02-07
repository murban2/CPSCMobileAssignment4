//
//  ViewController.swift
//  Assignment4
//
//  Created by user269254 on 2/6/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var timer: Timer?
    var timerTwo: Timer?
    
    var timerDuration: Double = 0.0
    var audioPlayer: AVAudioPlayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startClock()
        setButton()
        setTimerLabel()
        datePicker.setValue(UIColor.white, forKey: "textColor")
        
       
        
    }
    
    
    func setTimerLabel() {
        timerLabel.text = ""
    }
    
    func setButton() {
        startStopButton.setTitle("Start Timer", for: .normal)
        startStopButton.layer.borderWidth = 2
        startStopButton.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    
    @IBAction func clickTimerButton(_ sender: Any) {
        
        if startStopButton.currentTitle == "Start Timer" {
            
            setTimer()
        } else {
            stopMusic()
        }
        
    }
    
    func stopMusic() {
        audioPlayer?.stop()
        startStopButton.setTitle("Start Timer", for: .normal)
    }
    
    
    func setTimer() {
        timerDuration = datePicker.countDownDuration
        startStopButton.isEnabled = false
        
        timerTwo = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown() {
        if timerDuration >= 0 {
            
            let hours = Int(timerDuration) / 3600
            let minutes = (Int(timerDuration) % 3600) / 60
            let seconds = (Int(timerDuration) % 3600) % 60
            
            let fHours = String(format: "%02d", hours)
            let fMinutes = String(format: "%02d", minutes)
            let fSeconds = String(format: "%02d", seconds)
            
            timerLabel.text = "Time Remaining: \(fHours):\(fMinutes):\(fSeconds)"
            
            
        } else {
                        
            guard let url = Bundle.main.url(forResource: "ragtimeAudio", withExtension: "mp3") else {
                print("mp3 Not found")
                return
            }
            
            timerTwo?.invalidate()
            startStopButton.isEnabled = true
            startStopButton.setTitle("Stop Music", for: .normal)
            
            do {
                
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                print("LALA2")
                try AVAudioSession.sharedInstance().setActive(true)
                
                
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                print("PLAYING")
                audioPlayer?.play()
            }
            catch {
                print("Error playing MP3")
            }
            
            
        }
        
        
        timerDuration -= 15
        
    }
    
    
    
    func startClock() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        clockLabel.text = formatter.string(from: Date())
        
        let formatterTwo = DateFormatter()
        formatterTwo.dateFormat = "a"
        
        let amPm = formatterTwo.string(from: Date())
        
        if (amPm == "PM") {
            backgroundView.image = UIImage(named: "PMbackground")
        } else {
            backgroundView.image = UIImage(named: "AMbackground")
        }
        
        
        
    }

}


//
//  ViewController.swift
//  Assignment4
//
//  Created by user269254 on 2/6/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // outlet references
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //timers
    var timer: Timer?
    var timerTwo: Timer?
    
    //time duration selected and audioplayer
    var timerDuration: Double = 0.0
    var audioPlayer: AVAudioPlayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup
        startClock()
        setButton()
        setTimerLabel()
        
    
        
       
        
    }
    
    
    func setTimerLabel() {
        //starting text value for timer.
        timerLabel.text = "Waiting for timer."
    }
    
    func setButton() {
        //setting title and adding border to button.
        startStopButton.setTitle("Start Timer", for: .normal)
        startStopButton.layer.borderWidth = 2
        startStopButton.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    
    @IBAction func clickTimerButton(_ sender: Any) {
        //checking if timer should be set or music should be stopped
        //on button click
        if startStopButton.currentTitle == "Start Timer" {
            
            setTimer()
        } else {
            stopMusic()
        }
        
    }
    
    func stopMusic() {
        //stopping music
        audioPlayer?.stop()
        startStopButton.setTitle("Start Timer", for: .normal)
    }
    
    
    func setTimer() {
        //getting timer duration
        timerDuration = datePicker.countDownDuration
        startStopButton.isEnabled = false
        
        //setting a timer.
        timerTwo = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown() {
        //checking if the timer still has time left
        if timerDuration >= 0 {
            
            //getting timer durations in hour minutes and seconds.
            let hours = Int(timerDuration) / 3600
            let minutes = (Int(timerDuration) % 3600) / 60
            let seconds = (Int(timerDuration) % 3600) % 60
            
            //formatting the time.
            let fHours = String(format: "%02d", hours)
            let fMinutes = String(format: "%02d", minutes)
            let fSeconds = String(format: "%02d", seconds)
            
            //setting the time remaining text
            timerLabel.text = "Time Remaining: \(fHours):\(fMinutes):\(fSeconds)"
            
            
        } else {
                        
            //getting the audio resource
            guard let url = Bundle.main.url(forResource: "ragtimeAudio", withExtension: "mp3") else {
                print("mp3 Not found")
                return
            }
            
            //ending the timer
            timerTwo?.invalidate()
            startStopButton.isEnabled = true
            startStopButton.setTitle("Stop Music", for: .normal)
            
            //starting the audio
            do {
                
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
               
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
        
        //decrement time
        timerDuration -= 1
        
    }
    
    
    
    func startClock() {
        //setting clock timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock() {
        //formatting
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        
        //setting clock text
        clockLabel.text = formatter.string(from: Date())
        
        //getting AM or PM value
        let formatterTwo = DateFormatter()
        formatterTwo.dateFormat = "a"
        
        let amPm = formatterTwo.string(from: Date())
        
        //assigning background image based off of AM or PM
        if (amPm == "PM") {
            backgroundView.image = UIImage(named: "PMbackground")
        } else {
            backgroundView.image = UIImage(named: "AMbackground")
        }
        
        
        
    }

}

